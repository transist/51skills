class AlipayTransaction < PayFu::AlipayTransaction

  attr_accessible :raw_data

  def raw_data
    Hashie::Mash.new(self[:raw_data])
  end
end
