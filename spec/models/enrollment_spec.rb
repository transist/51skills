require 'spec_helper'

describe Enrollment do

  it 'should validate #payment_method to be included in PAYMENT_METHODS' do
    enrollment = build(:enrollment, payment_method: 'test')

    expect {
      enrollment.save!
    }.to raise_error(ActiveRecord::RecordInvalid)

    Enrollment::PAYMENT_METHODS.each do |m|
      enrollment.payment_method = m.to_s
      enrollment.save.should be_true
    end
  end

  it 'should be immediately paid when enroll a free course' do
    enrollment = create(:enrollment, course: create(:scheduled_free_course))
    enrollment.should be_paid
  end

  describe '#pay' do
    it 'should be paid when transaction success' do
      enrollment = create(:enrollment, :paid)
      enrollment.pay
      enrollment.should be_paid
    end

    it 'should not be paid when transaction not success' do
      enrollment = create(:enrollment, :unpaid)
      enrollment.pay
      enrollment.should_not be_paid
    end

    it 'should not be paid without transaction' do
      enrollment = create(:enrollment)
      enrollment.pay
      enrollment.should_not be_paid
    end
  end
end
