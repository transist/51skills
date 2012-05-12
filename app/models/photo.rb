class Photo < ActiveRecord::Base
  attr_accessible :image_content_type, :image_file_name, :image_file_size
  has_attached_file :image, :url => "/system/:hash/:style.:extension", :storage => :s3, 
                            :hash_data => ":class/:attachment/:id/:style/:created_at",
                            :styles => { :original => '940x680#', :full => '730x500#', :pin => '300x300#', :thumb => '100x100#', :tiny => '50x50#'},
                            :bucket => YAML::load(File.open(Rails.root.join("config/s3.yml")))[Rails.env][:bucket], 
                            :s3_credentials => YAML::load(File.open(Rails.root.join("config/s3.yml"))), 
                            :hash_secret => "longSecretS asdas das tring"
  resourcify
end
