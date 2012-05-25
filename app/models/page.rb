class Page < ActiveRecord::Base
  include TheSortableTree::Scopes
  attr_accessible :content_en, :content_zh, :slug, :title_en, :title_zh, :root, :parent_id
  translation_for :content, :title
  before_save :create_slug
  after_create :make_child_of_root
  acts_as_nested_set
  has_one :presentation
  scope :front, where(:root => true)
  resourcify
  
  def make_child_of_root
    Page.front.first.children << self
  end

  
  def create_slug
    self.slug = self.title_en.parameterize if self.slug == nil || self.slug == ''
  end
  
  def to_param
    self.slug
  end
  
  def slideshow
    if self.presentation
      self.presentation
    else
      Presentation.create(:page_id => self.id)
    end
  end
end
