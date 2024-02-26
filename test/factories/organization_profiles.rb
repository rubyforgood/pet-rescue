FactoryBot.define do
  factory :organization_profile do
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }
    about_us { Faker::Lorem.paragraph(sentence_count: 4) }
    location
    organization { ActsAsTenant.current_tenant }
  end
end
