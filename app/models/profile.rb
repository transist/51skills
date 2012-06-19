class Profile < ActiveRecord::Base
  attr_accessible :about, :person_id, :avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>", :tiny => '50x50>'}

  
end
