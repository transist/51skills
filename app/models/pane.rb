class Pane < ActiveRecord::Base
  attr_accessible :collage_id, :glueable_id, :glueable_type
  belongs_to :collage
  acts_as_nested_set
  has_and_belongs_to_many :photos
end
