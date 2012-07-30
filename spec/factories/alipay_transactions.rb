# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :alipay_transaction do
    enrollment
  end

  factory :paid_alipay_transaction, parent: :alipay_transaction do
    payment_status 'TRADE_SUCCESS'
  end
end
