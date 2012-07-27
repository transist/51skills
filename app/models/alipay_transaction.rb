class AlipayTransaction < PayFu::AlipayTransaction

  def raw_data
    Hashie::Mash.new(self[:raw_data])
  end
end
