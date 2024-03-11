FactoryBot.define do
  factory :task do
    name { "MyString" }
    description { "MyText" }
    completed { false }
    pet
    recurring { false }
    due_date { nil }
    next_due_date_in_days { nil }
  end
end
