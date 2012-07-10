class Course < ActiveRecord::Base
  attr_accessible :description_en, :description_zh, :facebook, :github, :linkedin, :name_en, :name_zh, 
                  :summary_en, :summary_zh, :twitter, :weibo, :image, :category_id, :start_date_time, :address, 
                  :price, :price_type
  acts_as_taggable
  acts_as_commentable
  
  has_attached_file :image, :url => "/system/:hash/:style.:extension", :storage => :s3, 
                            :hash_data => ":class/:attachment/:id/",
                            :styles => { :original => '300x300#', :thumb => '100x100#', :tiny => '50x50#'},
                            :bucket => YAML::load(File.open(Rails.root.join("config/s3.yml")))[Rails.env][:bucket], 
                            :s3_credentials => YAML::load(File.open(Rails.root.join("config/s3.yml"))), 
                            :hash_secret => "longSecretS asdas das tring"
  translation_for :name, :summary, :description
  before_save :update_searchable
  
  belongs_to :category
  belongs_to :owner, :class_name => "Person", :foreign_key => "owner_id"
  
  has_many :watches, :dependent => :destroy
  has_many :watchers, :through => :watches, :source => :person
  
  has_many :enrollments, :dependent => :destroy
  has_many :students, :through => :enrollments, :source => :person
  
  has_many :course_sessions
  
  validates_associated :category
  
  validate :price, :numericality => {:greater_than_or_equal_to => 0}, :allow_nil => true
  validates_inclusion_of :price_type, :in => [:cny, :usd]
  
  state_machine :state, :initial => :inactive do
    event :activate do
      transition [:inactive, :postponed] => :active
    end

    event :complete do
      transition :active => :completed
    end

    event :cancel do
      transition :active => :canceled
    end
    
    event :postpone do
      transition :active => :postponed
    end
    
  end
  
  def price_type
    att = read_attribute(:price_type)
    att.to_sym if att
  end

  def price_type= (value)
    write_attribute(:price_type, value.to_s)
  end
  
  def update_searchable
    self.searchable_summary_zh = Course.segment(self.summary_zh) unless self.summary_zh == nil
    self.searchable_description_zh = Course.segment(self.description_zh) unless self.description_zh == nil
    self.searchable_name_zh = Course.segment(self.name_zh) unless self.name_zh == nil
  end
  
  def self.segment(phrase)
    unless SEG_AP_ID.blank? || SEG_KEY.blank? || SEG_PRODUCT_ID.blank?
      client = CnTelecomeSeg::Base.new(SEG_AP_ID, SEG_KEY, SEG_PRODUCT_ID)
      logger.info client.inspect
      client.segment(phrase)['returnParams']['Msg'].split(/:/).join(' ')
    end
  end
  
  def save_category(category_id)
    self.category = Category.find(category_id)
    self.save
    self
  end
  
  def counting(times)
    $redis.zincrby(Course.courses_view_all_time_key, times, self.id.to_s) 
    $redis.zincrby(Course.courses_view_daily_key, times, self.id.to_s)
    $redis.zincrby(Course.courses_view_weekly_key, times, self.id.to_s)
    $redis.zincrby(Course.courses_category_view_all_time_key, times, self.category.id.to_s) 
    $redis.zincrby(Course.courses_category_view_daily_key, times, self.category.id.to_s)
    $redis.zincrby(Course.courses_category_view_weekly_key, times, self.category.id.to_s)
  end
  
  def rank
    rank = $redis.zrevrank(Course.courses_view_all_time_key, self.id.to_s)
    if rank
      rank + 1
    else
      nil
    end
  end
  
  def human_price
    (self.price == 0) ? "FREE!" : ("#{self.price_type.to_s.upcase} #{self.price.to_s}")
  end
  
  def self.top(rank)
    $redis.zrevrange(Course.courses_view_all_time_key, 0, rank - 1).map{|id| Course.find_by_id(id)}
  end
  
  def self.today_top(rank)
    $redis.zrevrange(Course.courses_view_daily_key, 0, rank - 1).map{|id| Course.find_by_id(id)}
  end
  
  def self.week_top(rank)
    $redis.zrevrange(Course.courses_view_weekly_key, 0, rank - 1).map{|id| Course.find_by_id(id)}
  end
  
  def score
    $redis.zscore(Course.courses_view_all_time_key, self.id.to_i).to_i
  end
  
  def daily_score
    $redis.zscore(Course.courses_view_daily_key, self.id.to_i).to_i
  end
  
  def weekly_score
    $redis.zscore(Course.courses_view_weekly_key, self.id.to_i).to_i
  end
  
  def self.courses_category_top(rank)
    $redis.zrevrange(Course.courses_category_view_all_time_key, 0, rank - 1).map{|id| Category.find_by_id(id)}
  end
  
  def self.courses_category_today_top(rank)
    $redis.zrevrange(Course.courses_category_view_daily_key, 0, rank - 1).map{|id| Category.find_by_id(id)}
  end
  
  def self.courses_category_week_top(rank)
    $redis.zrevrange(Course.courses_category_view_weekly_key, 0, rank - 1).map{|id| Category.find_by_id(id)}
  end
  
  def courses_category_score
    $redis.zscore(Course.courses_category_view_all_time_key, self.id.to_i).to_i
  end
  
  def courses_category_daily_score
    $redis.zscore(Course.courses_category_view_daily_key, self.id.to_i).to_i
  end
  
  def courses_category_weekly_score
    $redis.zscore(Course.courses_category_view_weekly_key, self.id.to_i).to_i
  end
  
  
  def self.courses_view_all_time_key
    "courses_view"
  end
  
  def self.courses_view_daily_key
    "courses_view_daily_#{Time.now.in_time_zone('Beijing').beginning_of_day.to_i.to_s}"
  end
  
  def self.courses_view_weekly_key
    "courses_view_weekly_#{Time.now.in_time_zone('Beijing').beginning_of_week.to_i.to_s}"
  end
  
  def self.courses_category_view_all_time_key
    "courses_category_view"
  end
  
  def self.courses_category_view_daily_key
    "courses_category_view_daily_#{Time.now.in_time_zone('Beijing').beginning_of_day.to_i.to_s}"
  end
  
  def self.courses_category_view_weekly_key
    "courses_category_view_weekly_#{Time.now.in_time_zone('Beijing').beginning_of_week.to_i.to_s}"
  end
  
end
