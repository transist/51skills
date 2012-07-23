require 'spec_helper'

describe Course do
  it 'should create a new instance via Factory' do
    expect {
      course = create(:course)
    }.to change(Course, :count).by(1)
  end

  it 'should validate presence of category' do
    expect {
      course = create(:course, category: nil)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  describe 'active course' do
    let(:course) { create(:active_course) }

    it 'can be scheduled when start_date_time exists' do
      course.start_date_time = 1.days.since
      course.should be_can_schedule
    end

    it 'can not be scheduled when start_date_time not exists' do
      course.should_not be_can_schedule
    end
  end
end
