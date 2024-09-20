FactoryBot.define do
  factory :location do
    # organization assigned by ActsAsTenant
    city_town { Faker::Address.city }
    sequence(:country) { |n| "Country#{n}" }
    province_state { Faker::Address.state }
    zipcode { Faker::Address.zip_code }
  end
end
