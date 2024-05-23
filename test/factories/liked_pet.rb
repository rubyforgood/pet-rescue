FactoryBot.define do
  factory :liked_pet do
    pet { association :pet }
    user { association :user }
  end
end
