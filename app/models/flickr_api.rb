#http://www.flickr.com/services/api/
#http://www.flickr.com/services/api/flickr.photos.search.html

class FlickrApi
  def self.client
    Flickr.new('config/flickr.yml')
  end
  
  def self.search(options)
    client.photos.search(options)
  end
end