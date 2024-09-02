FactoryBot.define do
  factory :adopter_application do
    notes { Faker::Lorem.paragraph }
    profile_show { true }
    status { 1 }

    transient do
      user { nil }
    end

    adopter_foster_account do
      if user
        user.adopter_foster_account ||
          association(:adopter_foster_account, user: user)
      else
        association :adopter_foster_account
      end
    end

    pet

    form_submission do
      if user
        user.person.form_submission ||
          association(:form_submission, person: user.person)
      else
        association :form_submission
      end
    end

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
