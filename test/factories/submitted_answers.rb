FactoryBot.define do
  factory :submitted_answer, class: "custom_form/submitted_answer" do
    value { JSON.dump Faker::Lorem.sentence }
    question_snapshot { question.snapshot }
    question
    user
  end
end
