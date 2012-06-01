class CourseSession < ActiveRecord::Base
  attr_accessible :descrption, :duration, :duration_type, :location, :session_datetime
end
