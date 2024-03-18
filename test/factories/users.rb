FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "john-#{n}@example.com" }
    password { "123456" }
    encrypted_password { Devise::Encryptor.digest(User, "123456") }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    tos_agreement { true }

    factory :adopter do
      adopter_account do
        association :adopter_account, user: instance
      end

      trait :with_profile do
        adopter_account do
          association :adopter_account, :with_profile, user: instance
        end
      end
    end

    factory :staff do
      staff_account do
        association :staff_account, user: instance
      end

      trait :deactivated do
        staff_account do
          association :staff_account, :deactivated, user: instance
        end
      end
    end

    factory :staff_admin do
      staff_account do
        association :staff_account, :admin, user: instance
      end
    end
  end
end
