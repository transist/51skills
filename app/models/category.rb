class Category < ActiveRecord::Base
  attr_accessible :name_en, :name_zh
  translation_for :name
end
