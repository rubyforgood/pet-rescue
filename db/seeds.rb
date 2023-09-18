# Seed data

@organization_one = Organization.create!(
  name: "Alta Pet Rescue",
  city: "Alta",
  country: "Mexico",
  zipcode: "12345",
  subdomain: "alta"
)

@organization_two = Organization.create!(
  name: "Ruby for Good Pet Rescue",
  city: "Washington, DC",
  country: "USA",
  zipcode: "12345",
  subdomain: "rfg"
)

@user_staff_one = User.create!(
  email: "staff@example.com",
  password: "123456",
  password_confirmation: "123456",
  tos_agreement: 1
)

@staff_account_one = StaffAccount.create!(
  user_id: @user_staff_one.id,
  organization_id: @organization_one.id,
  verified: true
)

@staff_account_one.add_role(
  :admin,
  @organization_one
)

@user_staff_two = User.create!(
  email: "staff2@example.com",
  password: "123456",
  password_confirmation: "123456",
  tos_agreement: 1
)

@staff_account_two = StaffAccount.create!(
  user_id: @user_staff_two.id,
  organization_id: @organization_two.id,
  verified: true
)

@staff_account_two.add_role(
  :admin,
  @organization_two
)

@user_adopter_one = User.create!(
  email: "adopter1@example.com",
  password: "123456",
  password_confirmation: "123456",
  tos_agreement: 1
)

@user_adopter_two = User.create!(
  email: "adopter2@example.com",
  password: "123456",
  password_confirmation: "123456",
  tos_agreement: 1
)

@user_adopter_three = User.create!(
  email: "adopter3@example.com",
  password: "123456",
  password_confirmation: "123456",
  tos_agreement: 1
)

 u = User.create!(email: Faker::Internet.email, password: "password123", tos_agreement: true)

@adopter_profile_one = Person.create!(
  adopter_account_id: @adopter_account_one.id,
  phone_number: Faker::PhoneNumber.phone_number,
  contact_method: "phone",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  user_id: u.id,

  referral_source: "my friends friend"
)

Location.create!(
  adopter_profile_id: @adopter_profile_one.id,
  country: "Canada",
  province_state: "Alberta",
  city_town: "Canmore"
)

 u2 = User.create!(email: Faker::Internet.email, password: "password123", tos_agreement: true)

@adopter_profile_two = AdopterProfile.create!(
  adopter_account_id: @adopter_account_two.id,
  phone_number: Faker::PhoneNumber.phone_number,
  contact_method: "phone",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  user_id: u2.id
  referral_source: "my friends friend"
)

Location.create!(
  adopter_profile_id: @adopter_profile_two.id,
  country: "USA",
  province_state: "Nevada",
  city_town: "Reno"
)

u3 = User.create!(email: Faker::Internet.email, password: "password123", tos_agreement: true)

@adopter_profile_three = AdopterProfile.create!(
  adopter_account_id: @adopter_account_three.id,
   phone_number: Faker::PhoneNumber.phone_number,
  contact_method: "phone",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  user_id: u3.id
  referral_source: "my friends friend"
)

Location.create!(
  adopter_profile_id: @adopter_profile_three.id,
  country: "Nonsense",
  province_state: "Nonsense",
  city_town: "Nonsense"
)

path = Rails.root.join("app", "assets", "images", "hero.jpg")
10.times do
  from_weight = [5, 10, 20, 30, 40, 50, 60].sample
  pet = Pet.create!(
    organization: Organization.all.sample,
    name: Faker::Creature::Dog.name,
    birth_date: Faker::Date.birthday(min_age: 0, max_age: 3),
    sex: Faker::Creature::Dog.gender,
    weight_from: from_weight,
    weight_to: from_weight + 15,
    weight_unit: Pet::WEIGHT_UNITS.sample,
    breed: Faker::Creature::Dog.breed,
    description: "He just loves a run and a bum scratch at the end of the day"
  )
  pet.images.attach(io: File.open(path), filename: "hero.jpg")
end

@match = Match.create!(
  pet_id: Pet.first.id,
  adopter_account_id: @adopter_account_one.id,
  organization_id: Pet.first.organization_id
)

10.times do
  AdopterApplication.create!(
    notes: Faker::Lorem.paragraph,
    profile_show: true,
    status: rand(0..5),
    adopter_account: AdopterAccount.all.sample,
    pet: Pet.all.sample
  )
end

@checklist_template = ChecklistTemplate.create!(
  name: "vaccinations",
  description: "Get your dog vaccinated"
)

5.times do
  @checklist_template.items.create!(
    name: Faker::Verb.base,
    description: Faker::Quote.famous_last_words,
    expected_duration_days: rand(1..10),
    required: [true, false].sample
  )
end

@match.assign_checklist_template(@checklist_template)

# active admin seed
AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password") if Rails.env.development?
