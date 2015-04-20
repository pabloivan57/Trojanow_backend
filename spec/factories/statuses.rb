FactoryGirl.define do
  factory :status do
    sequence(:title) { |t| "Title #{t}" }
    description 'Description'
    anonymous false
    user

    trait :anonymous do
      anonymous true
    end
  end
end
