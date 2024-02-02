FactoryBot.define do
  factory :adopter_account do
    transient do
      organization { ActsAsTenant.test_tenant }
    end

    user do
      if organization
        association :user, organization: organization
      else
        association :user
      end
    end

    trait :with_adopter_profile do
      adopter_profile { association :adopter_profile, adopter_account: instance }
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
      adopter_profile
    end
  end

  factory :organization do
    name { Faker::Company.name }
    sequence(:slug) { |n| Faker::Internet.domain_word + n.to_s }
    profile { association :organization_profile, organization: instance }
  end

  factory :organization_profile do
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }
    about_us { Faker::Lorem.paragraph(sentence_count: 4) }
    location
    organization { ActsAsTenant.test_tenant }
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
    organization { ActsAsTenant.test_tenant }
    placement_type { Faker::Number.within(range: 0..2) }
    published { true }

    trait :adoption_pending do
      adopter_applications { build_list(:adopter_application, 3, :adoption_pending) }
    end

    trait :adopted do
      match { association :match, organization: organization }
    end
  end

  factory :match do
    organization { ActsAsTenant.test_tenant }
    pet { association :pet, organization: organization }
    adopter_account { association :adopter_account, :with_adopter_profile, organization: organization }
  end

  factory :staff_account do
    organization { ActsAsTenant.test_tenant }
    user { association :user, organization: organization }
    deactivated_at { nil }

    trait :deactivated do
      deactivated_at { DateTime.now }
    end
  end

  factory :task do
    name { "MyString" }
    description { "MyText" }
    completed { false }
    pet
  end

  factory :default_pet_task do
    name { "MyString" }
    description { "MyText" }
    organization { ActsAsTenant.test_tenant }
  end

  factory :user do
    sequence(:email) { |n| "john-#{n}@example.com" }
    password { "123456" }
    encrypted_password { Devise::Encryptor.digest(User, "123456") }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    tos_agreement { true }

    organization { ActsAsTenant.test_tenant }

    trait :activated_staff do
      staff_account { association :staff_account, organization: organization }
      after(:create) { |user, context| user.add_role(:staff, context.organization) }
    end

    trait :staff_admin do
      staff_account { association :staff_account, organization: organization }
      after(:create) { |user, context| user.add_role(:admin, context.organization) }
    end

    trait :deactivated_staff do
      staff_account { association :staff_account, :deactivated, organization: organization }
      after(:create) { |user, context| user.add_role(:staff, context.organization) }
    end

    trait :adopter_without_profile do
      adopter_account
    end

    trait :adopter_with_profile do
      association :adopter_account, :with_adopter_profile
    end
  end
end
