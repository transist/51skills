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
end
