FactoryBot.define do
  factory :faq do
    question { Faker::Lorem.question }
    answer { Faker::Lorem.sentence }
    order { nil }
    organization { ActsAsTenant.current_tenant }
  end
end
