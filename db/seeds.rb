# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first

organization = Organization.create!(name: 'placeholder',
                               city: 'baja',
                               country: 'Mexico')
# organization.save

staff_user = User.new(email: 'a@b.com',
                      first_name: 'Andy',
                      last_name: 'Peters',
                      password: '123456',
                      password_confirmation: '123456',
                      tos_agreement: 1)

                      staff_user.save()

staff_account = StaffAccount.create!(user_id: 1,
                                 organization_id: 1,
                                 verified: true)
# staff_account.save

adopter_user_one = User.new(email: 'b@c.com',
                            first_name: 'Joe',
                            last_name: 'Brandon',
                            password: '123456',
                            password_confirmation: '123456',
                            tos_agreement: 1)

adopter_user_one.save()

adopter_account_one = AdopterAccount.create!(user_id: 2)
# adopter_account_one.save

adopter_user_two = User.create!(email: 'c@c.com',
                            first_name: 'Kamala',
                            last_name: 'Lollol',
                            password: '123456',
                            password_confirmation: '123456',
                            tos_agreement: 1)

adopter_user_two.save()

adopter_account_two = AdopterAccount.create!(user_id: 3)
# adopter_account_two.save

i = 1
until i == 10 do 
  dog = Dog.create!(organization_id: 1,
                name: "dog #{i}",
                age: (i + 1),
                sex: 'Male',
                size: 'Medium (22-57 lb)',
                breed: 'Husky mix',
                description: 'He just loves a run and a bum scratch at the end of the day')
  # dog.save
  i += 1
end

profile_one = AdopterProfile.create!(adopter_account_id: 1,
                                 phone_number: '250 548 7721',
                                 contact_method: 'phone',
                                 country: 'Canada',
                                 province_state: 'Alberta',
                                 city_town: 'Canmore',
                                 ideal_dog: 'I love a dog with energy and a gentle spirit. 
                                             One that snuggles on the couch in the evening.',
                                 lifestyle_fit: 'I work from home during the week and am always
                                                 at home. On weekends I do a lot of hiking.',
                                 activities: 'We will go to the dog park, daily walks x 2, and
                                              see friends with dogs regularly',
                                 alone_weekday: 2,
                                 alone_weekend: 1,
                                 experience: 'I have owned many dogs an currently have three rescue
                                              dogs and one foster dog',
                                 contingency_plan: 'My neighbour is a good friend and has looked after
                                                    my dogs multiple times and they get along very well',
                                 shared_ownership: true,
                                 shared_owner: 'My brother is often taking my dogs when his kids are over
                                                for the weekend as they just love the dogs',
                                 housing_type: 'Detached',
                                 fenced_access: true,
                                 location_day: 'In the house',
                                 location_night: 'In the house',
                                 do_you_rent: false,
                                 adults_in_home: 2, 
                                 kids_in_home: 1,
                                 other_pets: true,
                                 describe_pets: 'I have one cat that does not mind dogs at all',
                                 checked_shelter: true,
                                 surrendered_pet: true,
                                 describe_surrender: 'I had to surrender a cat when I was 19 because of university',
                                 annual_cost: '$2,000',
                                 visit_laventana: false,
                                 referral_source: 'my friends friend')
# profile_one.save

profile_two = AdopterProfile.create!(adopter_account_id: 2,
                                 phone_number: '250 548 7721',
                                 contact_method: 'phone',
                                 country: 'Canada',
                                 province_state: 'Alberta',
                                 city_town: 'Canmore',
                                 ideal_dog: 'I love a dog with energy and a gentle spirit. 
                                            One that snuggles on the couch in the evening.',
                                 lifestyle_fit: 'I work from home during the week and am always
                                                at home. On weekends I do a lot of hiking.',
                                 activities: 'We will go to the dog park, daily walks x 2, and
                                            see friends with dogs regularly',
                                 alone_weekday: 2,
                                 alone_weekend: 1,
                                 experience: 'I have owned many dogs an currently have three rescue
                                            dogs and one foster dog',
                                 contingency_plan: 'My neighbour is a good friend and has looked after
                                                  my dogs multiple times and they get along very well',
                                 shared_ownership: true,
                                 shared_owner: 'My brother is often taking my dogs when his kids are over
                                              for the weekend as they just love the dogs',
                                 housing_type: 'Detached',
                                 fenced_access: false,
                                 fenced_alternative: 'I plan to always be outside with my dog and walk them at the local park',
                                 location_day: 'In the house',
                                 location_night: 'In the house',
                                 do_you_rent: true,
                                 dogs_allowed: true,
                                 adults_in_home: 2,
                                 kids_in_home: 1,
                                 other_pets: true,
                                 describe_pets: 'I have one cat that does not mind dogs at all',
                                 checked_shelter: true,
                                 surrendered_pet: true,
                                 describe_surrender: 'I had to surrender a cat when I was 19 because of university',
                                 annual_cost: '$2,000',
                                 visit_laventana: true,
                                 visit_dates: 'April 2 to May 7 2023',
                                 referral_source: 'my friends friend')
# profile_two.save
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?