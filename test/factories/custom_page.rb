FactoryBot.define do
  factory :custom_page do
    hero { "MyString" }
    about { Faker::Lorem.sentence }
    # organization { ActsAsTenant.current_tenant }
    association :organization, factory: :organization

    trait :with_image do
      after(:create) do |custom_page|
        custom_page.about_us_images.attach(
          io: File.open(Rails.root.join("app", "assets", "images", "cat.jpeg")),
          filename: "cat.jpeg",
          content_type: "image/jpeg"
        )
      end
    end
  end
end
