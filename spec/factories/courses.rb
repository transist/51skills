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

  factory :course_with_start_date, parent: :course do
    t = Time.now.utc
    t = Time.utc(t.year, t.month, t.day + 2, t.hour, t.min, t.sec)
    start_date_time { t }
  end
end
