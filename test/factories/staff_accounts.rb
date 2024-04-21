FactoryBot.define do
  factory :staff_account do
    user { association :staff }
    deactivated_at { nil }

    trait :deactivated do
      deactivated_at { DateTime.now }
    end
  end
end
