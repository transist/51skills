class Page < ActiveRecord::Base
  attr_accessible :content_en, :content_zh, :slug, :title_en, :title_zh, :root
  translation_for :content, :title
  before_save :create_slug
  
  
  
  def create_slug
    self.slug = self.title_en.parameterize if self.slug == nil || self.slug == ''
  end
  
  def to_param
    self.slug
  end
end
