require 'spec_helper'

describe Person do
  let(:person) { create(:person) }

  it 'should create a new instance via Factory' do
    expect {
      person = create(:person)
    }.to change(Person, :count).by(1)
  end

  it 'should create an admin via Factory' do
    expect {
      admin = create(:admin)
      admin.should be_admin
    }.to change(Person, :count).by(1)
  end

  context '#enroll' do
    let(:course) { create(:scheduled_course) }

    it 'should enroll a scheduled course' do
      expect {
        person.enroll(course)
        course.students.should include(person)
      }.to change(Enrollment, :count).by(1)
    end

    it 'should return the enrollment when success' do
      person.enroll(course).should == Enrollment.last
    end

    it 'should not enroll an active course' do
      course = create(:active_course)

      expect {
        person.enroll(course).should be_false
        course.reload.students.should_not include(person)
      }.not_to change(Enrollment, :count)
    end
  end

  context '#disenroll' do

    let(:course) { create(:scheduled_course) }

    it 'should remove user from students of course' do
      person.enroll(course)

      expect {
        person.disenroll(course)
        course.students.should_not include(person)
        person.enrolled_courses.should_not include(course)
      }.to change(Enrollment, :count).by(-1)
    end
  end
end
