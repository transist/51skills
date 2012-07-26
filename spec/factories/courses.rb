# encoding: UTF-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    name_en 'Getting started with Rails'
    name_zh 'Rails 入门'
    association :category, factory: :sub_category
    price 50.0
    price_type :cny
  end

  factory :active_course, parent: :course do
    after(:create) {|c| c.activate }
  end

  factory :scheduled_course, parent: :active_course do
    start_date_time { 2.days.since }
    after(:create) {|c| c.schedule }
  end
end
