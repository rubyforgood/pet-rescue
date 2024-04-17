FactoryBot.define do
  factory :organization_profile do
    email { Faker::Internet.email }
    phone_number { "0000000000" }
    location
  end
end
