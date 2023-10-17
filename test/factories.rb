FactoryBot.define do
  factory :task do
    name { "MyString" }
    description { "MyText" }
    completed { false }
    pet { nil }
  end

  factory :adopter_account do
    user

    trait :with_adopter_profile do
      after :create do |account|
        create(:adopter_profile, adopter_account: account)
      end
    end
  end

  factory :adopter_application do
    notes { Faker::Lorem.paragraph }
    profile_show { true }
    status { 1 }

    adopter_account
    pet

    trait :adoption_pending do
      status { 2 }
    end

    trait :withdrawn do
      status { 3 }
      profile_show { false }
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
    location
  end

  factory :checklist_assignment do
    checklist_template_item
    match
  end

  factory :checklist_template do
    description { Faker::Lorem.paragraph }
    name { Faker::Lorem.word }
  end

  factory :checklist_template_item do
    expected_duration_days { 3 }
    name { Faker::Lorem.word }
    required { [true, false].sample }

    checklist_template
  end

  factory :location do
    city_town { Faker::Address.city }
    sequence(:country) { |n| "Country#{n}" }
    province_state { Faker::Address.state }
    zipcode { Faker::Address.zip_code }

    trait :with_adopter_profile do
      after :create do |location|
        create(:adopter_profile, location: location)
      end
    end
  end

  factory :organization do
    name { Faker::Company.name }
    slug { Faker::Internet.domain_word }
    profile { build(:organization_profile) }
  end

  factory :organization_profile do
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }

    location

    trait :with_organization do
      after :build do |profile|
        profile.organization = create(:organization, profile: profile)
      end
    end
  end

  factory :pet do
    birth_date { Faker::Date.backward(days: 7) }
    breed { Faker::Creature::Dog.breed }
    description { Faker::Lorem.sentence }
    name { Faker::Creature::Dog.name }
    sex { Faker::Creature::Dog.gender }
    weight_from { 10 }
    weight_to { 20 }
    weight_unit { "lb" }
    species { Faker::Number.within(range: 0..1) }
    organization

    trait :adoption_pending do
      adopter_applications { build_list(:adopter_application, 3, :adoption_pending) }
    end

    trait :application_paused_opening_soon do
      application_paused { true }
      pause_reason { 1 }
    end

    trait :application_paused_until_further_notice do
      application_paused { true }
      pause_reason { 2 }
    end

    trait :adopted do
      after :create do |pet|
        create :match, pet: pet, organization: pet.organization
      end
    end
  end

  factory :match do
    organization
    pet { create(:pet, organization: organization) }
    association :adopter_account, factory: [:adopter_account, :with_adopter_profile]
  end

  factory :staff_account do
    verified { true }

    organization
    user

    trait :unverified do
      verified { false }
    end

    trait :admin do
      after :create do |staff_account|
        staff_account.add_role(:admin, staff_account.organization)
      end
    end
  end

  factory :user do
    email { Faker::Internet.email }
    password { "123456" }
    encrypted_password { Devise::Encryptor.digest(User, "123456") }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    tos_agreement { true }

    organization

    trait :verified_staff do
      staff_account
    end

    trait :staff_admin do
      association(:staff_account, :admin)
    end

    trait :unverified_staff do
      staff_account { build(:staff_account, :unverified) }
    end

    trait :adopter_without_profile do
      adopter_account
    end

    trait :adopter_with_profile do
      adopter_account

      after :create do |user|
        create :adopter_profile, adopter_account: user.adopter_account
      end
    end

    trait :application_awaiting_review do
      adopter_account

      after :create do |user|
        create :adopter_application, adopter_account: user.adopter_account, status: 0
        user.adopter_account.adopter_profile = create(:adopter_profile)
      end
    end
  end
end
