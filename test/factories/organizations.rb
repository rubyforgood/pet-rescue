FactoryBot.define do
  factory :organization do
    name { Faker::Company.name }
    sequence(:slug) { |n| Faker::Internet.domain_word + n.to_s }
    profile { association :organization_profile, organization: instance }

    trait :with_custom_page do
      after(:create) do |organization|
        create(:custom_page, organization: organization) unless organization.custom_page
      end
    end
  end
end
