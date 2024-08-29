FactoryBot.define do
  factory :adopter_foster_account do
    user { association :adopter, adopter_foster_account: instance }

    factory :foster_account do
      user { association :fosterer, adopter_foster_account: instance }
    end
  end
end
