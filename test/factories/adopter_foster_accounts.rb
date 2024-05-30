FactoryBot.define do
  factory :adopter_foster_account do
    user { association :adopter, adopter_foster_account: instance }

    trait :with_profile do
      adopter_foster_profile do
        association :adopter_foster_profile, adopter_foster_account: instance
      end
    end

    factory :foster_account do
      user { association :fosterer, adopter_foster_account: instance }
    end
  end
end
