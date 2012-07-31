require 'spec_helper'

describe AlipayTransactionObserver do
  let(:alipay_transaction) { create(:alipay_transaction, @params) }

  it 'should set enrolmment to paid after create with paid' do
    @params = {payment_status: 'TRADE_SUCCESS'}
    alipay_transaction.enrollment.should be_paid
  end

  it 'should set enrolmment to paid after update with paid' do
    alipay_transaction.update_attributes(payment_status: 'TRADE_SUCCESS')
    alipay_transaction.enrollment.should be_paid
  end
end
