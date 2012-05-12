class Photo < ActiveRecord::Base
  attr_accessible :image_content_type, :image_file_name, :image_file_size
  has_attached_file :image, :url => "/system/:hash/:style.:extension", :storage => :s3, 
                            :hash_data => ":class/:attachment/:id/:style/:created_at",
                            :styles => { :short => '300x100#', :tall => '300x500#', :pin => '300x300#', :thumb => '100x100#', :tiny => '50x50#'},
                            :bucket => YAML::load(File.open(Rails.root.join("config/s3.yml")))[Rails.env][:bucket], 
                            :s3_host_alias => YAML::load(File.open(Rails.root.join("config/s3.yml")))[Rails.env][:s3_host_alias], 
                            :url => ':s3_alias_url',
                            :s3_credentials => YAML::load(File.open(Rails.root.join("config/s3.yml"))), 
                            :hash_secret => "longSecretS asdas das tring"
  resourcify
  
  translation_for :comment
  
  def self.search_flickr(q='tedxshanghai')
    FlickrApi.search(:text => q).each do |photo|
      puts photo.inspect
    end
  end
  
  def self.search_weibo(q='tedxshanghai')
    WeiboApi.search(q).each do |message|
      
    end
  end
  
  def self.search_twitter
    
  end
  
  def self.search_instagram
    
  end
  
  def self.initialize(options)
    
  end
end