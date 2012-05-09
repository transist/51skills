class Page < ActiveRecord::Base
  attr_accessible :content_en, :content_zh, :slug, :title_en, :title_zh, :root, :parent_id
  translation_for :content, :title
  before_save :create_slug
  acts_as_nested_set

  
  def create_slug
    self.slug = self.title_en.parameterize if self.slug == nil || self.slug == ''
  end
  
  def to_param
    self.slug
  end
end
