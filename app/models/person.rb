class Person < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  rolify
  attr_accessible :profile_attributes, :secret, :token, :uid, :username, :email, :mobile, :name, :password, :password_confirmation, :remember_me

  has_many :watches, :dependent => :destroy
  has_many :watching_courses, :through => :watches, :source => :course

  has_many :enrollments, :dependent => :destroy
  has_many :enrolled_courses, :through => :enrollments, :source => :course

  has_many :own_courses, :class_name => 'Course', :foreign_key => "owner_id"

  has_one :profile

  validates :email, :presence => {:message => "Your email is used to save your greeting."}, :unless => :skip_email_validation
  validates :email, :uniqueness => true, :unless => :skip_email_validation
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i, :unless => :skip_email_validation
  validates_confirmation_of :password, :unless => :skip_email_validation
  validates_length_of       :password, :within => 6..128, :allow_blank => true

  has_many :providers, :dependent => :destroy

  def self.create_with_omniauth(auth)
    person = create! do |user|
      user.instance_create_with_omniauth(auth)
    end
    person.disable_skip_email_validation
    person
  end

  def instance_create_with_omniauth(auth)
    enable_skip_email_validation
    provider = Provider.create_provider_with_omniauth(auth)
    self.email = provider.email
    self.name = provider.username
    self.password = Devise.friendly_token[0,20]
    self.providers << provider
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

  # For mixpanel identity temporary
  def identity
    email || providers.first.username
  end

  def enroll(course)
    if course.scheduled?
      course.students << self
      enrollment = course.enrollments.find_by_person_id(id)
      enrollment.notify
      enrollment
    else
      nil
    end
  end

  def disenroll(course)
    course.students.delete(self)
  end

  private
  def skip_email_validation
    @skip_email_validation
  end

  def disable_skip_email_validation
    @skip_email_validation = false
  end

  def enable_skip_email_validation
    @skip_email_validation = true
  end
end
