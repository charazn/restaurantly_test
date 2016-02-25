FactoryGirl.define do
  factory :restaurant do
    name "MyString"
    address "MyString"

    trait :invalid do
      name nil
    end

    trait :update do
      name "New name"
    end
  end
end
