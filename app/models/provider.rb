class Provider < ActiveRecord::Base
  attr_accessible :email, :profile_attributes, :provider, :secret, :token, :uid, :username
  
  belongs_to :person
end
