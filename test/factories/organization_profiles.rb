FactoryBot.define do
  factory :organization_profile do
    email { Faker::Internet.email }
    phone_number { "0000000000" }
    about_us { Faker::Lorem.paragraph(sentence_count: 4) }
    location
  end
end
