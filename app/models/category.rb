class Category < ActiveRecord::Base
  include TheSortableTree::Scopes
  
  attr_accessible :name_en, :name_zh
  translation_for :name
  acts_as_nested_set
  
  has_many :courses
  
  def self.main_categories
    Category.where(:depth => 0)
  end
  
  def sub_categories
    self.children
  end
  
  def main_category?
    self.depth == 0
  end
  
  def sub_category?
    self.depth == 1
  end
  
  
end
