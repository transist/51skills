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
  
  def counting(times)
    $redis.zincrby(Category.categories_view_all_time_key, times, self.id.to_s) 
    $redis.zincrby(Category.categories_view_daily_key, times, self.id.to_s)
    $redis.zincrby(Category.categories_view_weekly_key, times, self.id.to_s) 
  end
  
  def count
    $redis.zrevrank(Category.categories_view_all_time_key, self.id.to_s)
  end
  
  def rank
    rank = $redis.zrevrank(Category.categories_view_all_time_key, self.id.to_s)
    if rank
      rank + 1
    else
      nil
    end
  end
  
  def self.top(rank)
    $redis.zrevrange(Category.categories_view_all_time_key, 0, rank - 1).map{|id| Category.find_by_id(id)}
  end
  
  def self.today_top(rank)
    $redis.zrevrange(Category.categories_view_daily_key, 0, rank - 1).map{|id| Category.find_by_id(id)}
  end
  
  def self.week_top(rank)
    $redis.zrevrange(Category.categories_view_weekly_key, 0, rank - 1).map{|id| Category.find_by_id(id)}
  end
  
  def score
    $redis.zscore(Category.categories_view_all_time_key, self.id.to_i).to_i
  end
  
  def daily_score
    $redis.zscore(Category.categories_view_daily_key, self.id.to_i).to_i
  end
  
  def weekly_score
    $redis.zscore(Category.categories_view_weekly_key, self.id.to_i).to_i
  end
  
  def self.categories_view_all_time_key
    "categories_view"
  end
  
  def self.categories_view_daily_key
    "categories_view_daily_#{Time.now.in_time_zone('Beijing').beginning_of_day.to_i.to_s}"
  end
  
  def self.categories_view_weekly_key
    "categories_view_weekly_#{Time.now.in_time_zone('Beijing').beginning_of_week.to_i.to_s}"
  end
  
  
end
