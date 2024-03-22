FactoryBot.define do
  factory :match do
    pet { association :pet }
    adopter_foster_account { association :adopter_foster_account, :with_profile }
  end
end
