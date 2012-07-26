
class AlipayTransactionsController < PayFu::AlipayTransactionsController

  def notify
    notify = Alipay::Notification.new(request.new_post)
    if notify.acknowledge
      if transaction = PayFu::AlipayTransaction.find_by_transaction_id(notify.trade_no)
        transaction.update_attributes(transaction_attributes(notify))
      else
        PayFu::AlipayTransaction.create(transaction_attributes(notify))
      end
    end
    
  end

end

