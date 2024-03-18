FactoryBot.define do
  factory :page_text do
    hero { "MyString" }
    about { Faker::Lorem.sentence }
    organization { ActsAsTenant.current_tenant }
  end
end
