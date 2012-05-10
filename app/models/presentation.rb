class Presentation < ActiveRecord::Base
  attr_accessible :page_id, :height, :Width
  has_many :slides, :class_name => "slide", :foreign_key => "reference_id"
end
