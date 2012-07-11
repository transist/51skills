# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    association :category, factory: :sub_category
    price 50.0
    price_type :cny
  end
end
