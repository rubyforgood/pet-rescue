FactoryBot.define do
  factory :faq do
    question { "MyString" }
    answer { "MyText" }
    order { 1 }
    organization { nil }
  end
end
