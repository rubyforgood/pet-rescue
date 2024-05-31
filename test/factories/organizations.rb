FactoryBot.define do
  factory :organization do
    name { Faker::Company.name }
    sequence(:slug) { |n| Faker::Internet.domain_word + n.to_s }
    profile { association :organization_profile, organization: instance }

    trait :with_page_text do
      after(:create) do |organization|
        create(:page_text, organization: organization) unless organization.page_text
      end
    end
  end
end
