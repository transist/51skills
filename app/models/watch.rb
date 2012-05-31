class Watch < ActiveRecord::Base
  attr_accessible :course_id, :person_id
  belongs_to :person
  belongs_to :course
end
