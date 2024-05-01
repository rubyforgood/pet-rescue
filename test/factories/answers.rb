FactoryBot.define do
  factory :answer do
    value { JSON.dump Faker::Lorem.sentence }
    question_snapshot { question.snapshot }
    question
    user
  end
end
