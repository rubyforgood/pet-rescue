FactoryBot.define do
  factory :form_submission do
    # organization assigned by ActsAsTenant
    association :person
  end
end
