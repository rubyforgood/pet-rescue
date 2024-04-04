FactoryBot.define do
  factory :adopter_foster_account do
    user { association :user }

    trait :with_profile do
      adopter_foster_profile do
        association :adopter_foster_profile, adopter_foster_account: instance
      end
    end

    after(:build) do |_account, context|
      context.user.add_role(:adopter, context.user.organization)
    end
  end
end
