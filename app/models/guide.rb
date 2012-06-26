class Guide < ActiveRecord::Base
  attr_accessible :title_zh, :content_zh, :title_en, :content_en
  
  translation_for :title, :content
end
