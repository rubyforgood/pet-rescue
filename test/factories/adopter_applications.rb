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
          association(:adopter_foster_account, :with_profile, user: user)
      else
        association :adopter_foster_account, :with_profile
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
  end
end
