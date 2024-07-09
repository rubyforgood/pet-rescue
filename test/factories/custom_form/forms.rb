FactoryBot.define do
  factory :form, class: "custom_form/form" do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    title { name }
    instructions { Faker::Lorem.paragraph }
  end
end
