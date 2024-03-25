FactoryBot.define do
  factory :form do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    title { name }
    instructions { Faker::Lorem.paragraph }
    organization
  end
end
