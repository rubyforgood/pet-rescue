FactoryBot.define do
  factory :liked_pet do
    pet { association :pet }
    adopter_foster_account { association :adopter_foster_account }
  end
end
