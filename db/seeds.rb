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
  subdomain: "rubyforgood"
)

@user_staff_one = User.create!(
  email: "staff@example.com",
  password: "123456",
  password_confirmation: "123456",
  tos_agreement: 1
)

StaffAccount.create!(
  user_id: @user_staff_one.id,
  organization_id: @organization_one.id,
  verified: true
)

@user_staff_two = User.create!(
  email: "staff2@example.com",
  password: "123456",
  password_confirmation: "123456",
  tos_agreement: 1
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
  user_id: u.id

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
  pet = Pet.create!(
    organization: Organization.all.sample,
    name: Faker::Creature::Dog.name,
    age: Faker::Number.within(range: 1..10),
    sex: Faker::Creature::Dog.gender,
    size: Faker::Creature::Dog.size,
    breed: Faker::Creature::Dog.breed,
    description: "He just loves a run and a bum scratch at the end of the day"
  )
  pet.images.attach(io: File.open(path), filename: "hero.jpg")
end

Match.create!(
  pet_id: Pet.first.id,
  adopter_account_id: @adopter_account_one.id
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

# active admin seed
AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password") if Rails.env.development?
