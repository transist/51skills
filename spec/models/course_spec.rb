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

  describe 'scheduled free course' do
    let(:course) { create(:scheduled_free_course) }
    subject { course }
    its(:price) { should be_zero }
  end

  context 'should be schedulable only if price and start_date_time exists' do
    let(:course) { create(:course, @params) }

    it 'should be schedulable if price and start_date_time exists' do
      @params = {price: 0, start_date_time: 2.days.since}
      course.should be_schedulable
    end

    it 'should not be schedulable if price not exists' do
      @params = {price: nil, start_date_time: 2.days.since}
      course.should_not be_schedulable
    end

    it 'should not be schedulable if start_date_time not exists' do
      @params = {price: 0, start_date_time: nil}
      course.should_not be_schedulable
    end
  end
end
