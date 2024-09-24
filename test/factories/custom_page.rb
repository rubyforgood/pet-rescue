FactoryBot.define do
  factory :custom_page do
    # organization assigned by ActsAsTenant
    hero { "MyString" }
    about { Faker::Lorem.sentence }

    trait :with_hero_image do
      after(:create) do |custom_page|
        custom_page.hero_image.attach(
          io: File.open(Rails.root.join("test", "fixtures", "files", "test.png")),
          filename: "test.png",
          content_type: "image/png"
        )
      end
    end

    trait :with_about_us_image do
      after(:create) do |custom_page|
        custom_page.about_us_images.attach(
          io: File.open(Rails.root.join("test", "fixtures", "files", "test2.png")),
          filename: "test2.png",
          content_type: "image/png"
        )
      end
    end
  end
end
