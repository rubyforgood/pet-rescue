@organization = Organization.create!(
  name: "Baja",
  slug: "baja",
  email: "baja@email.com",
  phone_number: "250 816 8212",
  custom_page: CustomPage.new(hero: "hero text", about: "about us text")
)

ActsAsTenant.with_tenant(@organization) do
  @orga_location = Location.create!(
    country: "US",
    province_state: "NV",
    city_town: "BajaCity",
    zipcode: "12346"
  )

  @user_staff_one = User.create!(
    email: "staff@baja.com",
    first_name: "Andy",
    last_name: "Peters",
    password: "123456",
    password_confirmation: "123456",
    tos_agreement: 1
  )

  @staff_account_one = StaffAccount.create!(
    user_id: @user_staff_one.id
  )

  @user_staff_one.add_role(:super_admin, @organization)

  @user_staff_two = User.create!(
    email: "staff2@baja.com",
    first_name: "Randy",
    last_name: "Peterson",
    password: "123456",
    password_confirmation: "123456",
    tos_agreement: 1
  )

  @staff_account_two = StaffAccount.create!(
    user_id: @user_staff_two.id
  )

  @user_staff_two.add_role(:super_admin, @organization)

  @user_adopter_one = User.create!(
    email: "adopter1@baja.com",
    first_name: "Joe",
    last_name: "Brando",
    password: "123456",
    password_confirmation: "123456",
    tos_agreement: 1
  )

  @adopter_foster_account_one = AdopterFosterAccount.create!(user_id: @user_adopter_one.id)

  @user_adopter_one.add_role(:adopter, @organization)
  FormSubmission.create!(person_id: @user_adopter_one.person_id, organization_id: @user_adopter_one.organization_id)

  @user_adopter_two = User.create!(
    email: "adopter2@baja.com",
    first_name: "Kamala",
    last_name: "Lolsworth",
    password: "123456",
    password_confirmation: "123456",
    tos_agreement: 1
  )

  @adopter_foster_account_two = AdopterFosterAccount.create!(user_id: @user_adopter_two.id)

  @user_adopter_two.add_role(:adopter, @organization)
  FormSubmission.create!(person_id: @user_adopter_two.person_id, organization_id: @user_adopter_two.organization_id)

  @user_adopter_three = User.create!(
    email: "adopter3@baja.com",
    first_name: "Bad",
    last_name: "Address",
    password: "123456",
    password_confirmation: "123456",
    tos_agreement: 1
  )

  @adopter_foster_account_three = AdopterFosterAccount.create!(user_id: @user_adopter_three.id)

  @user_adopter_three.add_role(:adopter, @organization)
  FormSubmission.create!(person_id: @user_adopter_three.person_id, organization_id: @user_adopter_three.organization_id)

  @user_fosterer_one = User.create!(
    email: "fosterer1@baja.com",
    first_name: "Simon",
    last_name: "Petrikov",
    password: "123456",
    password_confirmation: "123456",
    tos_agreement: 1
  )

  @user_fosterer_one.create_adopter_foster_account!

  @user_fosterer_one.add_role(:adopter, @organization)
  @user_fosterer_one.add_role(:fosterer, @organization)

  @user_fosterer_two = User.create!(
    email: "fosterer2@baja.com",
    first_name: "Finn",
    last_name: "Mertens",
    password: "123456",
    password_confirmation: "123456",
    tos_agreement: 1
  )

  @user_fosterer_two.create_adopter_foster_account!

  @user_fosterer_two.add_role(:adopter, @organization)
  @user_fosterer_two.add_role(:fosterer, @organization)

  5.times do
    DefaultPetTask.create!(
      name: Faker::Lorem.word.capitalize,
      description: Faker::Lorem.sentence
    )
  end

  path = Rails.root.join("app", "assets", "images", "hero.jpg")
  25.times do
    from_weight = [5, 10, 20, 30, 40, 50, 60].sample
    pet = Pet.create!(
      name: Faker::Creature::Dog.name,
      birth_date: Faker::Date.birthday(min_age: 0, max_age: 3),
      sex: Faker::Creature::Dog.gender,
      weight_from: from_weight,
      weight_to: from_weight + 15,
      weight_unit: Pet::WEIGHT_UNITS.sample,
      breed: Faker::Creature::Dog.breed,
      description: "He just loves a run and a bum scratch at the end of the day",
      species: Pet.species["Dog"],
      placement_type: 1,
      published: true
    )
    pet.images.attach(io: File.open(path), filename: "hero.jpg")

    due_dates = [Date.today - 1.day, Date.today, Date.today + 30.days]
    DefaultPetTask.all.each_with_index do |task, index|
      Task.create!(
        pet_id: pet.id,
        name: task.name,
        description: task.description,
        due_date: due_dates[index]
      )
    end
  end

  Match.create!(
    pet_id: Pet.first.id,
    adopter_foster_account_id: @adopter_foster_account_one.id,
    match_type: :adoption
  )

  @fosterable_pets = Array.new(3) do
    from_weight = [5, 10, 20, 30, 40, 50, 60].sample
    Pet.create!(
      name: Faker::Creature::Dog.name,
      birth_date: Faker::Date.birthday(min_age: 0, max_age: 3),
      sex: Faker::Creature::Dog.gender,
      weight_from: from_weight,
      weight_to: from_weight + 15,
      weight_unit: Pet::WEIGHT_UNITS.sample,
      breed: Faker::Creature::Dog.breed,
      description: Faker::Lorem.sentence,
      species: Pet.species["Dog"],
      placement_type: "Fosterable",
      published: true
    )
  end

  # Complete foster
  complete_start_date = Time.now - 4.months
  complete_end_date = complete_start_date + 3.months
  Match.create!(
    pet_id: @fosterable_pets[0].id,
    adopter_foster_account_id: @user_fosterer_one.adopter_foster_account.id,
    match_type: :foster,
    start_date: complete_start_date,
    end_date: complete_end_date
  )

  # Current foster
  current_start_date = Time.now - 2.months
  current_end_date = current_start_date + 6.months
  Match.create!(
    pet_id: @fosterable_pets[1].id,
    adopter_foster_account_id: @user_fosterer_one.adopter_foster_account.id,
    match_type: :foster,
    start_date: current_start_date,
    end_date: current_end_date
  )

  # Upcoming foster
  upcoming_start_date = Time.now + 1.week
  upcoming_end_date = upcoming_start_date + 3.months
  Match.create!(
    pet_id: @fosterable_pets[2].id,
    adopter_foster_account_id: @user_fosterer_two.adopter_foster_account.id,
    match_type: :foster,
    start_date: upcoming_start_date,
    end_date: upcoming_end_date
  )

  10.times do
    adopter_application = AdopterApplication.new(
      notes: Faker::Lorem.paragraph,
      profile_show: true,
      status: rand(0..4),
      form_submission: FormSubmission.all.sample,
      pet: Pet.all.sample
    )

    # Prevent duplicate adopter applications.
    redo if AdopterApplication.where(pet_id: adopter_application.pet_id,
      form_submission_id: adopter_application.form_submission_id).exists?

    if adopter_application.valid?
      adopter_application.save!
    else
      redo
    end
  end

  5.times do
    Faq.create!(
      question: Faker::Lorem.question(word_count: 4, random_words_to_add: 10),
      answer: Faker::Lorem.sentence(word_count: 1, random_words_to_add: 50)
    )
  end
end
