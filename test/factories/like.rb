FactoryBot.define do
  factory :like do
    pet { association :pet }
    adopter_foster_account { association :adopter_foster_account }
  end
end
