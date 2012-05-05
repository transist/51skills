Rails.application.config.middleware.use OmniAuth::Builder do
  provider :weibo, Weibo::Config.api_key, Weibo::Config.api_secret
end
