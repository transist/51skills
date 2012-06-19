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
  validate :price, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates_inclusion_of :price_type, :in => [:cny, :usd]
  
  def price_type
    read_attribute(:price_type).to_sym
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
  
end
