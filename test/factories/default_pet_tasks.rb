FactoryBot.define do
  factory :default_pet_task do
    name { "MyString" }
    description { "MyText" }
    organization { ActsAsTenant.current_tenant }
  end
end
