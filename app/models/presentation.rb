class Presentation < ActiveRecord::Base
  attr_accessible :page_id, :height, :width
  has_many :slides, :class_name => "slide", :foreign_key => "reference_id"
  
  def cropping_width
    self.width || 700
  end
  
  def cropping_height
    self.width || 500
  end
end
