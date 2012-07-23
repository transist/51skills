# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    association :category, factory: :sub_category
    price 50.0
    price_type :cny
  end

  factory :active_course, parent: :course do
    state :active
  end

  factory :scheduled_course, parent: :course do
    start_date_time { 2.days.since }
  end
end
