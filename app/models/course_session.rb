class CourseSession < ActiveRecord::Base
  attr_accessible :description_zh, :description_en, :duration, :duration_type, :location, :session_datetime, :title_zh, :title_en
  
  belongs_to :course
end
