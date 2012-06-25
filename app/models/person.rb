class Person < ActiveRecord::Base
	rolify
  attr_accessible :profile_attributes, :secret, :token, :uid, :username, :email, :mobile, :name
  
  has_many :watches, :dependent => :destroy
  has_many :watching_courses, :through => :watches, :source => :course
  
  has_many :enrollments, :dependent => :destroy
  has_many :enrolled_courses, :through => :enrollments, :source => :course
  
  has_many :own_courses, :class_name => 'Course', :foreign_key => "owner_id"
  
  has_one :profile
  
  validates :email, :presence => {:message => "Your email is used to save your greeting."}, :unless => :skip_email_validation
  validates :email, :uniqueness => true, :unless => :skip_email_validation
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i, :unless => :skip_email_validation
  validates :name, :presence => {:message => "Your name is used to save your greeting."}, :unless => :skip_email_validation

  def self.create_with_omniauth(auth)
    person = create! do |user|
      user.instance_create_with_omniauth(auth)
    end
    person.disable_skip_email_validation
    person
  end
  
  def instance_create_with_omniauth(auth)
    enable_skip_email_validation
    self.provider = auth['provider']
    self.uid = auth['uid']
    case auth['provider']
    when 'weibo'
      self.name = auth['info']['name'] || ""
      self.email = auth['info']['email'] || ""
      self.mobile = ""
      self.username = auth['extra']['raw_info']['screen_name'] || ""
      self.token = auth['extra']['access_token'].token
      self.secret = auth['extra']['access_token'].secret
      self.uid = auth['extra']['raw_info']['id']
      self.profile_attributes = auth['extra'].to_json
    when 'twitter'
      self.name = auth['info']['name'] || ""
      self.email = ""
      self.mobile = ""
      self.username = auth['info']['nickname'] || ""
      self.token = auth['credentials'].token
      self.secret = auth['credentials'].secret
      self.uid = auth['uid']
      self.profile_attributes = auth['extra'].to_json
    when 'facebook'
      self.name = auth['info']['nickname']
      self.email = auth['info']['email']
      self.mobile = ""
      self.username = auth['info']['name']
      self.token = auth['credentials'].token
      self.secret = ""
      self.uid = auth['uid']
      self.profile_attributes = auth['extra'].to_json
    end
    self
  end
  
  def self.unique_email(email)
    !Person.find_by_email(email).nil?
  end
  
  def profile_hash
    Hashie::Mash.new JSON.parse(self.profile_attributes)
  end
  
  def admin?
    self.has_role? :admin
  end
  
  def client
    oauth = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret)
    oauth.authorize_from_access(self.token, self.secret)
    Weibo::Base.new(oauth)
  end
  
  def disable_skip_email_validation
    @skip_email_validation = false
  end
  
  private
  def skip_email_validation
    @skip_email_validation
  end
  
  def enable_skip_email_validation
    @skip_email_validation = true
  end
  
  
end
