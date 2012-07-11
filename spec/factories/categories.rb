# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
  end

  factory :sub_category, class: 'Category' do
    association :parent, factory: :category
  end
end
