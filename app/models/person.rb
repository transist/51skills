class Person < ActiveRecord::Base
	rolify
  attr_accessible :profile_attributes, :secret, :token, :uid, :username, :email, :mobile, :name
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
         user.mobile = ""
         user.username = auth['extra']['raw_info']['screen_name'] || ""
         user.token = auth['extra']['access_token'].token
         user.secret = auth['extra']['access_token'].secret
         user.uid = auth['extra']['raw_info']['id']
         user.profile_attributes = auth['extra'].to_json
      end
    end
  end
  
  def profile
    Hashie::Mash.new JSON.parse(self.profile_attributes)
  end
  
  def admin?
    true
  end
  
  def client
    oauth = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret)
    oauth.authorize_from_access(self.token, self.secret)
    Weibo::Base.new(oauth)
  end
end
