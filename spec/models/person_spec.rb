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

    it 'should enroll a scheduled course' do
      course = create(:scheduled_course)

      expect {
        person.enroll(course).should be_true
        course.students.should include(person)
      }.to change(Enrollment, :count).by(1)
    end

    it 'should not enroll an active course' do
      course = create(:active_course)

      expect {
        person.enroll(course).should be_false
        course.students.should_not include(person)
      }.not_to change(Enrollment, :count).by(1)
    end
  end
end
