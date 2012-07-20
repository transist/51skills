# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    name_en 'Programming'
  end

  factory :sub_category, class: 'Category' do
    association :parent, factory: :category
    name_en 'Web'
  end
end
