class Presentation < ActiveRecord::Base
  attr_accessible :page_id, :height, :width
  belongs_to :page
  has_many :slides
  resourcify
  
  def cropping_width
    self.width || 730
  end
  
  def cropping_height
    self.width || 500
  end
end
