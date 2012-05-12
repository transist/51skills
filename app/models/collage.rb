class Collage < ActiveRecord::Base
  attr_accessible :config, :name, :page_id
  has_many :panes
end
