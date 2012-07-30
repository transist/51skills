class AlipayTransactionObserver < ActiveRecord::Observer
  def after_save(alipay_transaction)
    alipay_transaction.enrollment.pay if alipay_transaction.paid?
  end
end
