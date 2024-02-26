FactoryBot.define do
  factory :match do
    organization { ActsAsTenant.current_tenant }
    pet { association :pet, organization: organization }
    adopter_account { association :adopter_account, :with_adopter_profile }
  end
end
