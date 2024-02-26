FactoryBot.define do
  factory :match do
    pet { association :pet }
    adopter_account { association :adopter_account, :with_adopter_profile }
  end
end
