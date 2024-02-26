FactoryBot.define do
  factory :adopter_account do
    transient do
      organization { ActsAsTenant.current_tenant }
    end

    user { association :user, organization: organization }

    trait :with_adopter_profile do
      after(:build) do |account|
        build(:adopter_profile, adopter_account: account)
      end
    end

    after(:build) do |_account, context|
      context.user.add_role(:adopter, context.organization)
    end
  end
end
