FactoryBot.define do
  factory :task do
    name { "MyString" }
    description { "MyText" }
    completed { false }
    pet
  end
end
