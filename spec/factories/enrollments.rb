# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :enrollment do
    payment_method :alipay
    course
  end

  trait :paid do
    after(:create) {|e|
      create(:paid_alipay_transaction, enrollment: e)
    }
  end

  trait :unpaid do
    after(:create) {|e|
      create(:alipay_transaction, enrollment: e)
    }
  end
end
