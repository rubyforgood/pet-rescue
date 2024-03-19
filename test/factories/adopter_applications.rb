FactoryBot.define do
  factory :adopter_application do
    notes { Faker::Lorem.paragraph }
    profile_show { true }
    status { 1 }

    transient do
      user { nil }
    end

    adopter_account do
      if user
        user.adopter_account ||
          association(:adopter_account, :with_profile, user: user)
      else
        association :adopter_account, :with_profile
      end
    end

    pet

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
