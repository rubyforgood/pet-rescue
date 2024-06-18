FactoryBot.define do
  factory :page_text do
    hero { "MyString" }
    about { Faker::Lorem.sentence }
    association :organization, factory: :organization

    trait :with_hero_image do
      after(:create) do |page_text|
        page_text.hero_image.attach(
          io: File.open(Rails.root.join("test", "fixtures", "files", "test.png")),
          filename: "test.png",
          content_type: "image/png"
        )
      end
    end

    trait :with_about_us_image do
      after(:create) do |page_text|
        page_text.about_us_images.attach(
          io: File.open(Rails.root.join("test", "fixtures", "files", "test2.png")),
          filename: "test2.png",
          content_type: "image/png"
        )
      end
    end
  end
end
