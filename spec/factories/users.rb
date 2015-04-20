# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@spinvite.com" }
    password 'admin123'
    confirmed_at Time.now
  end
end
