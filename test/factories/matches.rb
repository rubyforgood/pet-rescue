FactoryBot.define do
  factory :match do
    pet { association :pet }
    adopter_foster_account { association :adopter_foster_account, :with_profile }
    match_type { :adoption }

    factory :foster do
      pet { association :pet, placement_type: "Fosterable" }
      match_type { :foster }
      adopter_foster_account { association :foster_account, :with_profile }
    end
  end
end
