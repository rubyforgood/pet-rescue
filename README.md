# Dog Adoption Ruby on Rails Application

I am a self-taught web developer and this is my first production Ruby on Rails application with real users. I love coding, and I love my dog. So, I wanted to give back to the grassroots organization where I adopted my dog from in Mexico by building them a web application to make the process of linking adopters with dogs easier.


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

I decided that a ruby on rails application would be a suitable technology because it enables rapid development and its REST framework will provide all of the required functionality. I chose to use a PostgreSQL database because it is robust and works readily with Ruby on Rails and Heroku, where the staging and production applications will be deployed on the Hobby Tier. Last, I opted to use the SendGrid app on Heroku to manage SMTP for mail, and Amazon S3 for image hosting.


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

**Gems and Installs**

* Devise
* Figaro
* Bootstrap CSS
* Better errors
* Guard and Guard live reload
* Letter opener
* Active Storage Validations
* Phone lib
* Active storage



### Contributions

This project has benefited from contributions on front end development so far, and would benefit from additional contributions. 

Picking up an issue:
* check the Issues tab for a list of work that needs completing. 
* if you are interested in an issue and it is unassigned, leave a comment on the issue to claim it, then I will assign it to you. 

Before you make a pull request: 
* make sure the changes you have made are specific to the scope of work in the issue.
* make sure the acceptance criteria stated in the issue are met. 
* only commit relevant files with your intended changes. Do not commit any files that may have changed e.g., if you had to change the gemfile to run the application locally.
* make sure the test suite passes `rails test`

A pull request will be reviewed and there may be feedback or questions related to changes, so please be prepared to follow up on those. A pull request will be merged once it looks good, and passes the test suite in the Github Actions pipeline.


### Local Setup

To set this application up locally:
* `rails -v` to ensure you have Rails 7.0.3 installed
* `ruby -v` to ensure you have Ruby version 3.0.3 or later installed
* `psql --version` to ensure you have PostgreSQL 12.12 installed (make sure you have a user and password)
* If you need more information on setting up PostgreSQL with rails, see here: https://www.theodinproject.com/lessons/ruby-on-rails-installing-postgresql
* Fork the repository and copy SSH key
* `git clone <'SSH Key'>` to download application locally
* `bundle install` to install gems (you may have to change gem 'sassc-rails' to gem 'sassc', "~> 2.1.0")
* `bundle exec figaro install`
* add your PostgreSQL database username and database password to `config/application.yml` as ENV variables
* `rails db:migrate` to run all migrations
* `rails db:seed` to load seed data
* `rails s` to run the local server
* `localhost:3000` in web browser to access the application

A user account is associated with either an adopter account or staff account. 
Staff accounts by default are `verified: false` and belong to `organization_id: 1`
Therefore, you will need to do the following things in `rails console` before you can access the full functionality of staff. 
1) Create an organization `a = Organization.new(name: 'Placeholder')` `a.save`
2) Create a staff account via the app UI
3) Find that user account by finding the `user_id` e.g., `User.find_by(email: 'enter email here')`
4) Find that staff account using the `user_id` e.g., `a = StaffAccount.find_by(user_id: '#')`
5) Then set the staff account verified to true `a.verified = true`, `a.save`
