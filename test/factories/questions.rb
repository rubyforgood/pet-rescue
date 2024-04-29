FactoryBot.define do
  factory :question do
    name { Faker::Lorem.question }
    description { Faker::Lorem.sentence }
    label { name }
    help_text { Faker::Lorem.sentence }
    input_type { "short" }
    options { {} }
    required { false }
    sort_order { 0 }

    form
  end
end
