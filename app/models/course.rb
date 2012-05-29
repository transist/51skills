class Course < ActiveRecord::Base
  attr_accessible :description_en, :description_zh, :facebook, :github, :linkedin, :name_en, :name_zh, :summary_en, :summary_zh, :twitter, :weibo, :image
  acts_as_taggable
  has_attached_file :image, :url => "/system/:hash/:style.:extension", :storage => :s3, 
                            :hash_data => ":class/:attachment/:id/",
                            :styles => { :original => '300x300#', :thumb => '100x100#', :tiny => '50x50#'},
                            :bucket => YAML::load(File.open(Rails.root.join("config/s3.yml")))[Rails.env][:bucket], 
                            :s3_credentials => YAML::load(File.open(Rails.root.join("config/s3.yml"))), 
                            :hash_secret => "longSecretS asdas das tring"
  translation_for :name, :summary, :description
  before_save :update_searchable
  
  def update_searchable
    self.searchable_summary_en = self.summary_en.split(' ').join(' ')
    self.searchable_summary_zh = self.summary_zh.split('').join(' ')
    self.searchable_description_en = self.description_en.split(' ').join(' ')
    self.searchable_description_zh = self.description_zh.split('').join(' ')
  end
end
