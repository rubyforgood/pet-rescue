FactoryBot.define do
  factory :faq do
    # organization assigned by ActsAsTenant
    question { Faker::Lorem.question }
    answer { Faker::Lorem.sentence }
    order { nil }
  end
end
