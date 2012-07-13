# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :person, aliases: [:user] do
    email
    password 'password'
  end
  
  factory :admin, parent: :person do
    after(:create) {|person| person.add_role :admin }
  end
end
