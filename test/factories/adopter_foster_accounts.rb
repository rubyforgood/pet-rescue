FactoryBot.define do
  factory :adopter_foster_account do
    user { association :user }

    trait :with_profile do
      after(:build) do |account|
        build(:adopter_foster_profile, adopter_foster_account: account)
      end
    end

    after(:build) do |_account, context|
      context.user.add_role(:adopter, context.user.organization)
    end
  end
end
