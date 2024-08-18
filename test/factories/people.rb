FactoryBot.define do
  factory :person do
    # organization assigned by ActsAsTenant
    name { Faker::Name.name }
    email { Faker::Internet.email }

    trait :with_phone do
      phone { Faker::PhoneNumber.phone_number }
    end
  end
end
