FactoryBot.define do
  factory :adopter_account do
    user
  end

  factory :adopter_application do
    notes { Faker::Lorem.paragraph }
    profile_show { [true, false].sample }
    status { 1 }

    adopter_account
    pet

    trait :adoption_pending do
      status { 2 }
    end
  end

  factory :adopter_profile do
    phone_number { "250-598-8843" }
    contact_method { "Phone" }
    ideal_pet { "Huge and soft" }
    lifestyle_fit { "Active" }
    activities { "Walking and camping" }
    alone_weekday { 3 }
    alone_weekend { 3 }
    experience { "Tons" }
    contingency_plan { "Friends" }
    shared_ownership { false }
    housing_type { "Detached" }
    fenced_access { true }
    location_day { "house" }
    location_night { "house" }
    do_you_rent { false }
    adults_in_home { 2 }
    kids_in_home { 2 }
    other_pets { false }
    checked_shelter { true }
    surrendered_pet { false }
    annual_cost { "not much" }
    visit_laventana { false }
    referral_source { "friends" }

    adopter_account
  end

  factory :checklist_template do
    description { Faker::Lorem.paragraph }
    name { Faker::Lorem.word }
  end

  factory :organization do
  end

  factory :pet do
    birth_date { Faker::Date.backward(days: 7) }
    breed { Faker::Creature::Dog.breed }
    description { Faker::Lorem.sentence }
    name { Faker::Creature::Dog.name }
    sex { Faker::Creature::Dog.gender }
    weight_from {10}
    weight_to {20}
    weight_unit {'lb'}

    organization

    trait :adoption_pending do
      adopter_applications { build_list(:adopter_application, 3, :adoption_pending) }
    end

    trait :application_paused do
      application_paused { true }
    end
  end

  factory :staff_account do
    verified { true }

    organization
    user

    trait :unverified do
      verified { false }
    end
  end

  factory :user do
    email { Faker::Internet.email }
    password { "123456" }
    encrypted_password { Faker::Lorem.word }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    tos_agreement { true }

    trait :verified_staff do
      staff_account
    end

    trait :unverified_staff do
      staff_account { build(:staff_account, :unverified) }
    end

    trait :adopter_with_profile do
      adopter_account

      after :create do |user|
        create :adopter_profile, adopter_account: user.adopter_account
      end
    end
  end
end
