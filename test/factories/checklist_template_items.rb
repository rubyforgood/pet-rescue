FactoryBot.define do
  factory :checklist_template_item do
    expected_duration_days { 3 }
    name { Faker::Lorem.word }
    required { [true, false].sample }

    checklist_template
  end
end
