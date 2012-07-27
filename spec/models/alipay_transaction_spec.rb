require 'spec_helper'

describe AlipayTransaction do
  let(:alipay_transaction) { create(:alipay_transaction) }

  context '#raw_data' do
    it 'should store mash data' do
      mash = Hashie::Mash.new({a: '1', b: '2'})
      alipay_transaction.raw_data = mash
      alipay_transaction.save
      alipay_transaction.reload.raw_data.should == mash
    end

    it 'should store hash data as mash' do
      hash = {a: '1', b: '2'}
      alipay_transaction.raw_data = hash
      alipay_transaction.save
      alipay_transaction.reload.raw_data.should == Hashie::Mash.new(hash)
    end
  end
end
