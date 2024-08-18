FactoryBot.define do
  factory :match do
    pet { association :pet }
    person { association :person }
    match_type { :adoption }

    factory :foster do
      pet { association :pet, placement_type: "Fosterable" }
      match_type { :foster }
      adopter_foster_account { association :foster_account }
      person { association :person } # Foster person
      start_date { Faker::Time.between(from: 1.year.ago, to: 1.month.from_now) }
      end_date { start_date + rand(3..6).months }
    end
  end
end
