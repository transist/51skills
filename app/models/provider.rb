class Provider < ActiveRecord::Base
  attr_accessible :email, :profile_attributes, :provider, :secret, :token, :uid, :username
  
  belongs_to :person
  
  def self.create_provider_with_omniauth(auth)
    provider = Provider.new
    provider.provider = auth['provider']
    case auth['provider']
    when 'weibo'
      provider.username = auth['info']['name'] || ""
      provider.email = auth['info']['email'] || ""
      provider.username = auth['extra']['raw_info']['screen_name'] || ""
      provider.token = auth['extra']['access_token'].token
      provider.secret = auth['extra']['access_token'].secret
      provider.uid = auth['extra']['raw_info']['id']
      provider.profile_attributes = auth['extra'].to_json
    when 'twitter'
      provider.username = auth['info']['name'] || ""
      provider.email = ""
      provider.username = auth['info']['nickname'] || ""
      provider.token = auth['credentials'].token
      provider.secret = auth['credentials'].secret
      provider.uid = auth['uid']
      provider.profile_attributes = auth['extra'].to_json
    when 'facebook'
      provider.username = auth['info']['nickname']
      provider.email = auth['info']['email']
      provider.username = auth['info']['name']
      provider.token = auth['credentials'].token
      provider.secret = ""
      provider.uid = auth['uid']
      provider.profile_attributes = auth['extra'].to_json
    end
    provider
  end
end
