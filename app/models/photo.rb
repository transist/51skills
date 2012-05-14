class Photo < ActiveRecord::Base
  attr_accessible :image_content_type, :image_file_name, :image_file_size, :download_url
  has_attached_file :image, :url => "/system/:hash/:style.:extension", :storage => :s3, 
                            :hash_data => ":class/:attachment/:id/",
                            :styles => { :short => '300x100#', :tall => '300x500#', :pin => '300x300#', :thumb => '100x100#', :tiny => '50x50#'},
                            :bucket => YAML::load(File.open(Rails.root.join("config/s3.yml")))[Rails.env][:bucket], 
                            :s3_credentials => YAML::load(File.open(Rails.root.join("config/s3.yml"))), 
                            :hash_secret => "longSecretS asdas das tring"
  resourcify
  
  translation_for :comment
  has_and_belongs_to_many :panes
  
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
  
  def self.initialize(url)
    p = self.find_by_download_url(url)
    unless p
      p = Photo.new(:download_url => url)
      p.download
      p.save
    end
    p
  end
  
  def download(url=self.download_url)
    begin
      io = open(URI.escape(url))
      if io
        def io.original_filename; base_uri.path.split('/').last; end
        io.original_filename.blank? ? nil : io
        self.image = io
      end
    rescue Exception => e
      logger.info "EXCEPTION# #{e.message}"
    end
  end
end