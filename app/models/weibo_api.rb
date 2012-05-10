class WeiboApi
  def self.client
    oauth = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret)
    Weibo::Base.new(oauth)
  end
  
  def self.search(options)
    client.status_search.(options)
  end
end