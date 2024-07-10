FactoryBot.define do
  factory :form_submission do
    association :person
    association :organization
  end
end
