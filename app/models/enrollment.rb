class Enrollment < ActiveRecord::Base
  attr_accessible :course_id, :person_id
  belongs_to :person
  belongs_to :course
  
  def notify
    email = Email.build("Your enrollment has been confirmed!", self.person.email, "enrollment_confirmed", {:name => self.person.name, :course_name => self.course.name(I18n.locale)}, true)
    Resque.enqueue(Email, email.id) if email.save
  end
end
