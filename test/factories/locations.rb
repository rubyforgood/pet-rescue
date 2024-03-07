FactoryBot.define do
  factory :location do
    city_town { Faker::Address.city }
    sequence(:country) { |n| "Country#{n}" }
    province_state { Faker::Address.state }
    zipcode { Faker::Address.zip_code }

    trait :with_profile do
      adopter_foster_profile
    end
  end
end
