FactoryBot.define do
  factory :organization do
    name { Faker::Company.name }
    sequence(:slug) { |n| Faker::Internet.domain_word + n.to_s }
    profile { association :organization_profile, organization: instance }
  end
end
