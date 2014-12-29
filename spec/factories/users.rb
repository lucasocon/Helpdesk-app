FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user-##{n}@helpdesk.test" }

    password "123123123"
    password_confirmation "123123123"

    trait :confirmed do
      confirmed_at { Time.now.utc }
    end
  end
end
