# Pet Rescue Adoption Application

The Pet Rescue app is derived from the [Baja Pet Rescue Dog Adoption Application](https://github.com/kasugaijin/baja-pet-rescue/tree/main) created by @kasugaijin who wanted to give back to the grassroots organization from where he adopted his dog in Mexico by building them a web application. Pet Rescue is an application that makes it easy to link adopters with pets.

---
### The organizations
#### Ruby for Good
Pet Rescue is one of many projects initiated and run by Ruby for Good. You can find out more about Ruby for Good at https://rubyforgood.org

#### Pet Rescue adoption sites
[Baja Pet Rescue](https://www.bajapetrescue.com)

---

#### Preparation Work (Before code)
These are just some of the documents put together before writing any code:
* Slide deck to pitch idea to client: [here](https://docs.google.com/presentation/d/1d4gjzADk7BcxmQEVZlesheGUen9d1E3RzrVvskMhVxo/edit?usp=sharing)
* Figma site design: [here](https://www.figma.com/file/x3iM31l8csY7mT0VwKykhT/BPR---Wireframes---Ami?node-id=530186%3A154&t=mgRlseVd2LTKPX4o-1)
* Model association diagram: [here](https://lucid.app/lucidchart/a915c03c-3c09-454d-837b-f3d2768f5722/edit?viewport_loc=-25%2C-973%2C3565%2C2341%2C0_0&invitationId=inv_85cf2967-7b33-4030-903f-9655e767cbbf)

---
**Dependencies**

* Devise (User authentication)
* Figaro (Environment variable management)
* Bootstrap CSS (Styling)
* Better errors (Error messaging in development)
* Guard and Guard live reload (Automatically reloads browser when view files change in development)
* Letter opener (Preview mail in the browser in development)
* Active Storage Validations (Validate attachments e.g., file type and size)
* Phone lib (Validate and format international phone numbers)
* Active sorage validations (easy validations for file uploads)
* SimpleCov (Generate test coverage metrics)
* Active Admin (Admin dashboard to easily verify new staff)
* Geocoder (Generate coordinates from adopter location for successes map)
* aws-sdk-s3 (integration with AWS to use image buckets)

### Local Setup

To set this application up locally:
* `rails -v` to ensure you have Rails 7.0.3 installed
* Run `rbenv versions` or `rvm list rubies` and confirm that Ruby 3.1.1 is installed
* `psql --version` to ensure you have PostgreSQL 12.12 installed (make sure you have a user and password)
* If you need more information on setting up PostgreSQL with rails, see [here](https://www.theodinproject.com/lessons/ruby-on-rails-installing-postgresql)
* Fork the repository and copy SSH key
* `git clone <'SSH Key'>` to download application locally
* `bundle install` to install gems (you may have to change gem 'sassc-rails' to gem 'sassc', "~> 2.1.0")
* `bundle exec figaro install`
* Add your PostgreSQL database username and database password to `config/application.yml` as ENV variables e.g., `DATABASE_USERNAME: "username"` `DATABASE_PASSWORD: "password`
* `rails db:setup` to create the database, load the schema, and load seed data
* `rails s` to run the local server
* `localhost:3000` in web browser to access the application


**Setting Up Staff Users**

A user account is associated with either an adopter account or staff account. 
Staff accounts by default are `verified: false` and belong to a placeholder organization, `organization_id: 1`.
Therefore, you will need to do the following things in `rails console` before you can access the full functionality of staff. 
1) Create an organization `Organization.create(name: 'Placeholder')`
2) Create a staff account via the app UI
3) Find that user account by finding the `user_id` e.g., `User.find_by(email: 'enter email here')`
4) Set the staff account verified to true `user_id` e.g., `StaffAccount.find_by(user_id: '#').update(verified: true)`
