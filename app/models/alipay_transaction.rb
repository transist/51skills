class AlipayTransaction < PayFu::AlipayTransaction

  belongs_to :enrollment

  serialize :raw_data, Hash

  attr_accessible :enrollment_id, :raw_data

  def raw_data
    Hashie::Mash.new(self[:raw_data])
  end

  def paid?
    payment_status == 'TRADE_SUCCESS'
  end
end
