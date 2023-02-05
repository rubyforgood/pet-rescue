# Baja Pet Rescue Dog Adoption Application

I am a self-taught web developer and this is my first production Ruby on Rails application with a real user base. I love coding, and I love my dog. So, I wanted to give back to the grassroots organization where I adopted my dog from in Mexico by building them a web application to make their process of linking adopters with dogs easier.

This codebase has been very successful so far, enabling 20 adoptions within its first ten weeks. However, I still have a lot to learn and always appreciate feedback. My curiosity for learning led me to provide this codebase to Jason Swett from Code with Jason to review on his live webinar in Jan, 2023. Thank you Jason! It was a great experience to learn from you and others on the call about how the code could be refactored for improvement. See the [video](https://youtu.be/0Otyx30pfzY) on his YouTube.


### The Problem

The dog rescue organization has limited time and resources. They have been using Facebook and Instagram to post new dogs and get interest from adopters. This has been working, but is not ideal because:
* staff are forced to use the platform's layout for dog posts
* staff have a hard time keeping track of applications for each dog
* staff have to use a third party adoption application form
* staff have insufficient resources to build/maintain a website
* there are no free, 'off the shelf' CMS solutions available for this domain
* there is limited ability to customise or brand online presence and build credibility
* adopters have to duplicate efforts each time they apply to adopt a dog
* adopters have no easy way to check the status of their application
* adopters have to use a patchwork process comprised of different apps
* adopters have to be registered on a social media platform and know how to navigate it


### The Solution

I met with the stakeholders to learn about their challenges and needs and then conceptualized a solution to address the above challenges. This was a great exercise in turning business needs into application logic. 

The solution had to be simple, easy to maintain and manage, and provide a more cohesive flow and experience for both staff and adopters alike. It had to make use of out of the box technology with a low monthly overhead.

I decided that a ruby on rails application would be a suitable technology because it enables rapid development and its REST framework provides all of the required functionality. I chose a PostgreSQL database because it is robust and works readily with Ruby on Rails and Heroku, where the production application lives. Last, I opted to use the SendGrid app on Heroku to manage SMTP for mail, and Amazon S3 for image hosting.

#### Preparation Work (Before code)
These are just some of the documents put together before writing any code:
* Slide deck to pitch idea to client: [here](https://docs.google.com/presentation/d/1d4gjzADk7BcxmQEVZlesheGUen9d1E3RzrVvskMhVxo/edit?usp=sharing)
* Figma site design: [here](https://www.figma.com/file/x3iM31l8csY7mT0VwKykhT/BPR---Wireframes---Ami?node-id=530186%3A154&t=mgRlseVd2LTKPX4o-1)
* Model association diagram: [here](https://lucid.app/lucidchart/a915c03c-3c09-454d-837b-f3d2768f5722/edit?viewport_loc=-25%2C-973%2C3565%2C2341%2C0_0&invitationId=inv_85cf2967-7b33-4030-903f-9655e767cbbf)

#### Features

The application has the following features:
* Authentication for two user types - adopters and organization staff
* Organization staff can perform CRUD actions on dogs on behalf of an organization
* Active storage for image uploads
* Amazon S3 for uploaded image hosting
* Adopters can create, read and update their profile, which contains vetting information
* Adopters can create adoption applications for a dog and view their application history/status and withdraw from an application
* Organization staff can review application requests for a dog, set a status, keep ongoing notes, and revert a withdrawn application to active
* Organization staff can create adoptions linking a dog with an adopter user
* Organization staff can filter their dogs by name or application status to make searching easier
* Mailer sends an email to organization staff for any new adoption requests on their dogs
* Mailer sends admin an email when a new staff registration occurs
* Mailer sends new adopters a welcome email
* Mailer handles the contact form on the website
* Authorizations to control the actions of users i.e. only adopters can apply to adopt dogs and only verified staff can carry out staff actions.
* Forms make use of Stimulus Javascript framework to provide features like conditional fields and character counters.
* Styling is achieved using Bootstrap 5
* Model associations and tables allow for scalability such that multiple organizations could operate under this application, each with control over their own dogs.

#### To Do

* Achieve 95%+ test coverage for all features and user flows via integration and system tests. **Currently under way**
* Refactor controllers and models to better organize code based on the live code review by Jason Swett. 
* Build out the *Successes* page, an interactive map (using Google Maps API) showing pins of all adopted dogs in their new hometown. [See Project](https://github.com/users/kasugaijin/projects/1/settings)


**Dependencies**

* Devise (User authentication)
* Figaro (Environment variable management)
* Bootstrap CSS (Styling)
* Better errors (Error messaging in development)
* Guard and Guard live reload (Automatically reloads browser when view files change in development)
* Letter opener (Preview mail in the browser in development)
* Active Storage Validations (Validate attachments e.g., file type and size)
* Phone lib (Validate and format international phone numbers)
* Active storage (Enable file attachments)
* SimpleCov (Generate test coverage metrics)
* Active Admin (Admin dashboard to easily verify new staff)



### Contributions

This project has benefited from front and back end contributions. More contributors of all skill levels are welcome. 

Picking up an issue:
* check the Issues tab for a list of work that needs completing. 
* if you are interested in an issue and it is unassigned, leave a comment on the issue to claim it, then I will assign it to you.
* please take only one issue at a time i.e., pick up the next issue after your current PR is merged. 

Before you make a pull request:
* merge main branch into your branch and run `bundle install` to make sure you have the latest changes.
* make sure the changes you have made are specific to the scope of work in the issue.
* make sure the acceptance criteria stated in the issue are met. 
* only commit relevant files with your intended changes. Do not commit any files that may have changed e.g., if you had to change the gemfile to run the application locally.
* make sure the full test suite passes by running `rails test:all`.

A pull request will be reviewed and there may be feedback or questions related to changes, so please be prepared to follow up on those. Pull requests are usually reviewed daily. A pull request will be merged once it looks good, and passes the test suite in the Github Actions pipeline.


### Local Setup

To set this application up locally:
* `rails -v` to ensure you have Rails 7.0.3 installed
* `ruby -v` to ensure you have Ruby version 3.0.3 or later installed
* `psql --version` to ensure you have PostgreSQL 12.12 installed (make sure you have a user and password)
* If you need more information on setting up PostgreSQL with rails, see [here](https://www.theodinproject.com/lessons/ruby-on-rails-installing-postgresql)
* Fork the repository and copy SSH key
* `git clone <'SSH Key'>` to download application locally
* `bundle install` to install gems (you may have to change gem 'sassc-rails' to gem 'sassc', "~> 2.1.0")
* `bundle exec figaro install`
* Add your PostgreSQL database username and database password to `config/application.yml` as ENV variables
* `rails db:migrate` to run all migrations
* `rails db:seed` to load seed data
* `rails s` to run the local server
* `localhost:3000` in web browser to access the application


**Setting Up Staff Users**

A user account is associated with either an adopter account or staff account. 
Staff accounts by default are `verified: false` and belong to a placeholder organization, `organization_id: 1`.
Therefore, you will need to do the following things in `rails console` before you can access the full functionality of staff. 
1) Create an organization `a = Organization.new(name: 'Placeholder')` `a.save`
2) Create a staff account via the app UI
3) Find that user account by finding the `user_id` e.g., `User.find_by(email: 'enter email here')`
4) Find that staff account using the `user_id` e.g., `a = StaffAccount.find_by(user_id: '#')`
5) Then set the staff account verified to true `a.verified = true`, `a.save`

### Test Coverage
Test coverage metrics are generated by the SimpleCov gem. Reading online you will see this gem is not always perfect but it does give a good insight into what code is covered and what is not. There are two things to note: 
* It is not necessary to generate coverage metrics every time the test suite is run e.g., in the CI pipeline. Therefore I have scoped its initiation under an environment variable. `COVERAGE`. 
* After some experimentation, I found that it was not reporting accurate test coverage metrics when running tests in parallel workers. Therefore, when running the test suite with coverage, the number of workers should be set to one `PARALLEL_WORKERS=1`.

To run the entire test suite, with coverage: `PARALLEL_WORKERS=1 COVERAGE=true rails test:all`.

You can view the HTML metrics in your browser by `cd coverage` from the application's root folder, and opening `index.html` in your browser.