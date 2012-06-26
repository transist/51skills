class Profile < ActiveRecord::Base
  attr_accessible :about, :person_id, :avatar
  
  has_attached_file :avatar, :url => "/system/:hash/:style.:extension", 
                             :storage => :s3,
                             :default_url => "/assets/:style_default_avatar.png",
                             :hash_data => ":class/:attachment/:id/",
                             :styles => { :medium => "300x300>", :thumb => "100x100>", :tiny => '50x50>'},
                             :bucket => YAML::load(File.open(Rails.root.join("config/s3.yml")))[Rails.env][:bucket], 
                             :s3_credentials => YAML::load(File.open(Rails.root.join("config/s3.yml"))), 
                             :hash_secret => "longSecretS asdas das tring"

  
end
