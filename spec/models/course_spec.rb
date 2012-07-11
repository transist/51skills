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
end
