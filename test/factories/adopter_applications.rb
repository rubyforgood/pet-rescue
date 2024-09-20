FactoryBot.define do
  factory :adopter_application do
    notes { Faker::Lorem.paragraph }
    profile_show { true }
    status { 1 }

    transient do
      user { nil }
    end

    pet
    form_submission

    trait :adoption_pending do
      status { 2 }
    end

    trait :withdrawn do
      status { 3 }
      profile_show { false }
    end

    trait :successful_applicant do
      status { 4 }
    end
  end
end
