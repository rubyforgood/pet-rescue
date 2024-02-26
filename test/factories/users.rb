FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "john-#{n}@example.com" }
    password { "123456" }
    encrypted_password { Devise::Encryptor.digest(User, "123456") }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    tos_agreement { true }

    organization { ActsAsTenant.current_tenant }

    factory :adopter do
      adopter_account do
        association :adopter_account, user: instance,
          organization: organization
      end

      trait :with_profile do
        adopter_account do
          association :adopter_account, :with_adopter_profile, user: instance,
            organization: organization
        end
      end
    end

    factory :staff do
      staff_account do
        association :staff_account, user: instance,
          organization: organization
      end

      trait :deactivated do
        staff_account do
          association :staff_account, :deactivated, user: instance,
            organization: organization
        end
      end
    end

    factory :staff_admin do
      staff_account do
        association :staff_account, :admin, user: instance,
          organization: organization
      end
    end
  end
end
