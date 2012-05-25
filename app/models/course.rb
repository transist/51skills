class Course < ActiveRecord::Base
  attr_accessible :description_en, :description_zh, :facebook, :github, :linkedin, :name_en, :name_zh, :summary_en, :summary_zh, :twitter, :weibo
  acts_as_taggable
  has_attached_file :image, :url => "/system/:hash/:style.:extension", :storage => :s3, 
                            :hash_data => ":class/:attachment/:id/",
                            :styles => { :original => '300x300#', :thumb => '100x100#', :tiny => '50x50#'},
                            :bucket => YAML::load(File.open(Rails.root.join("config/s3.yml")))[Rails.env][:bucket], 
                            :s3_credentials => YAML::load(File.open(Rails.root.join("config/s3.yml"))), 
                            :hash_secret => "longSecretS asdas das tring"
end
