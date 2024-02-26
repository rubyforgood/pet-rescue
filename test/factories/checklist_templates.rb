FactoryBot.define do
  factory :checklist_template do
    description { Faker::Lorem.paragraph }
    name { Faker::Lorem.word }
  end
end
