@organization = Organization.create!(
  name: "Alta Pet Rescue",
  slug: "alta",
  email: "alta@email.com",
  phone_number: "250 816 8212",
  custom_page: CustomPage.new(hero: "Where every paw finds a home", about: "Alta was founded by an incredible group of ladies in April of 2020. Our initial goal was to have both a rescue and a spay/neuter clinic, however, we quickly realized that it would be more efficient to separate into two organizations."),
  external_form_url: "https://docs.google.com/forms/d/e/1FAIpQLSf9bI-kboxyQQB5I1W5pt0R25u9pHoXI7o3jQHKu1P4K-61mA/viewform?embedded=true"
)

ActsAsTenant.with_tenant(@organization) do
  @orga_location = Location.create!(
    country: "US",
    province_state: "NY",
    city_town: "AltaCity",
    zipcode: "12345"
  )

  @staff_one = Person.create!(
    email: "staff@alta.com",
    first_name: "Andy",
    last_name: "Peters"
  )

  @user_staff_one = @staff_one.create_user!(
    email: "staff@alta.com",
    first_name: "Andy",
    last_name: "Peters",
    password: "123456",
    password_confirmation: "123456",
    tos_agreement: 1
  )

  # FIXME: Delete this after implementing Person
  @staff_account_one = StaffAccount.create!(
    user_id: @user_staff_one.id
  )

  @user_staff_one.add_role(:super_admin, @organization)

  @staff_two = Person.create!(
    email: "staff2@alta.com",
    first_name: "Randy",
    last_name: "Peterson"
  )

  @user_staff_two = @staff_two.create_user!(
    email: "staff2@alta.com",
    first_name: "Randy",
    last_name: "Peterson",
    password: "123456",
    password_confirmation: "123456",
    tos_agreement: 1
  )

  # FIXME: Delete this after implementing Person
  @staff_account_two = StaffAccount.create!(
    user_id: @user_staff_two.id
  )

  @user_staff_two.add_role(:super_admin, @organization)

  @adopter_one = Person.create!(
    email: "adopter1@alta.com",
    first_name: "Joe",
    last_name: "Brando"
  )

  @user_adopter_one = @adopter_one.create_user!(
    email: "adopter1@alta.com",
    first_name: "Joe",
    last_name: "Brando",
    password: "123456",
    password_confirmation: "123456",
    tos_agreement: 1
  )

  @user_adopter_one.add_role(:adopter, @organization)

  @adopter_one.form_submissions.create!

  @adopter_two = Person.create!(
    email: "adopter2@alta.com",
    first_name: "Kamala",
    last_name: "Lolsworth"
  )

  @user_adopter_two = @adopter_two.create_user!(
    email: "adopter2@alta.com",
    first_name: "Kamala",
    last_name: "Lolsworth",
    password: "123456",
    password_confirmation: "123456",
    tos_agreement: 1
  )

  @user_adopter_two.add_role(:adopter, @organization)

  @adopter_two.form_submissions.create!

  @adopter_three = Person.create!(
    email: "adopter3@alta.com",
    first_name: "Bad",
    last_name: "Address"
  )

  @user_adopter_three = @adopter_three.create_user!(
    email: "adopter3@alta.com",
    first_name: "Bad",
    last_name: "Address",
    password: "123456",
    password_confirmation: "123456",
    tos_agreement: 1
  )

  @user_adopter_three.add_role(:adopter, @organization)

  @adopter_three.form_submissions.create!

  @fosterer_one = Person.create!(
    email: "fosterer1@alta.com",
    first_name: "Simon",
    last_name: "Petrikov"
  )

  @user_fosterer_one = @fosterer_one.create_user!(
    email: "fosterer1@alta.com",
    first_name: "Simon",
    last_name: "Petrikov",
    password: "123456",
    password_confirmation: "123456",
    tos_agreement: 1
  )

  @user_fosterer_one.add_role(:adopter, @organization)
  @user_fosterer_one.add_role(:fosterer, @organization)

  @fosterer_two = Person.create!(
    email: "fosterer2@alta.com",
    first_name: "Finn",
    last_name: "Mertens"
  )

  @user_fosterer_two = @fosterer_two.create_user!(
    email: "fosterer2@alta.com",
    first_name: "Finn",
    last_name: "Mertens",
    password: "123456",
    password_confirmation: "123456",
    tos_agreement: 1
  )

  @user_fosterer_two.add_role(:adopter, @organization)
  @user_fosterer_two.add_role(:fosterer, @organization)

  5.times do
    DefaultPetTask.create!(
      name: Faker::Lorem.word.capitalize,
      description: Faker::Lorem.sentence
    )
  end

  @lifestyle_form = CustomForm::Form.create!(
    name: "Lifestyle",
    description: "Questions regarding the applicant's lifestyle.",
    title: "Lifestyle",
    instructions: "Please answer these questions about your lifestyle as they pertain to your ability to care for a pet.",
    organization: @organization
  )

  FormProfile.create!(
    form: @lifestyle_form,
    profile_type: "adopter",
    sort_order: 0
  )

  @ideal_pet_question = CustomForm::Question.create!(
    name: "Ideal pet",
    description: "Brief description of the applicant's ideal pet.",
    label: "Your ideal pet",
    help_text: "Briefly describe your ideal pet.",
    required: true,
    input_type: "short",
    sort_order: 0,
    form: @lifestyle_form
  )

  @lifestyle_question = CustomForm::Question.create!(
    name: "General lifestyle",
    description: "Brief description of the applicant's lifestyle.",
    label: "Your lifestyle",
    help_text: "Briefly describe your lifestyle.",
    required: true,
    input_type: "short",
    sort_order: 1,
    form: @lifestyle_form
  )

  @activities_question = CustomForm::Question.create!(
    name: "Activities",
    description: "Brief description of the applicant's activities.",
    label: "Your activities",
    help_text: "Briefly describe activities you will do with your pet.",
    required: true,
    input_type: "short",
    sort_order: 2,
    form: @lifestyle_form
  )

  path = Rails.root.join("app", "assets", "images", "hero.jpg")
  50.times do
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
      placement_type: 0,
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

  match_application = AdopterApplication.create!(
    pet_id: Pet.first.id,
    form_submission_id: @adopter_one.form_submissions.first.id,
    status: :successful_applicant
  )

  Match.create!(
    pet_id: Pet.first.id,
    person_id: @adopter_one.id,
    match_type: :adoption
  )
  match_application.update!(status: :adoption_made)

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
    person_id: @fosterer_one.id,
    match_type: :foster,
    start_date: complete_start_date,
    end_date: complete_end_date
  )

  # Current foster
  current_start_date = Time.now - 2.months
  current_end_date = current_start_date + 6.months
  Match.create!(
    pet_id: @fosterable_pets[1].id,
    person_id: @fosterer_one.id,
    match_type: :foster,
    start_date: current_start_date,
    end_date: current_end_date
  )

  # Upcoming foster
  upcoming_start_date = Time.now + 1.week
  upcoming_end_date = upcoming_start_date + 3.months
  Match.create!(
    pet_id: @fosterable_pets[2].id,
    person_id: @fosterer_two.id,
    match_type: :foster,
    start_date: upcoming_start_date,
    end_date: upcoming_end_date
  )

  10.times do
    adopter_application = AdopterApplication.new(
      notes: Faker::Lorem.paragraph,
      profile_show: true,
      status: rand(0..4),
      pet: Pet.all.sample,
      form_submission: FormSubmission.all.sample
    )

    # Prevent duplicate adopter applications.
    redo if AdopterApplication.where(
      pet_id: adopter_application.pet_id,
      form_submission_id: adopter_application.form_submission_id
    ).exists?

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
