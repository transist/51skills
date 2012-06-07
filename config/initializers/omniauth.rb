Rails.application.config.middleware.use OmniAuth::Builder do
  provider :weibo, Weibo::Config.api_key, Weibo::Config.api_secret
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], :display => 'popup'
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end
