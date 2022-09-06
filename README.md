# Dog Adoption Ruby on Rails Application

I am a self-taught web developer and this is my first production Ruby on Rails application with real users. I love coding, and I love my dog. So, I wanted to give back to the grassroots organization where I adopted my dog from in Mexico by building them a web application to make the process of linking adopters with dogs easier.


**The Problem**

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
* adopters have to be registered on a platform and know how to navigate it (think non-technical boomer trying to learn Instagram)


**The Solution**

I met with the stakeholder to learn about their challenges and needs and then conceptualized a solution to address the above challenges. This was a great exercise in turning business needs into application logic. 

The solution had to be simple, easy to maintain and manage, and provide a more cohesive flow and experience for both staff and adopters alike. It had to make use of out of the box technology with a low monthly overhead.

I decided that a ruby on rails application would be a suitable technology because it enables rapid development and its REST framework will provide all of the required functionality. I chose to use a PostgreSQL database because it is robust and works readily with Ruby on Rails and Heroku, where the staging and production applications will be deployed on the Hobby Tier. Last, I opted to use the SendGrid app on Heroku to manage SMTP for mail. 


**Features**

The application has the following features:
* Authentication for two user types - adopters and organization staff
* Organization staff can perform CRUD actions on dogs on behalf of an organization
* Active storage to allow image uploads and a bootstrap carousel for display
* Adopters can create, read and update their profile, which contains vetting information
* Adopters can create adoption applications for a dog and view their application history/status
* Organization staff can review application requests for a dog, set a status, and keep ongoing notes
* Organization staff can create adoptions linking a dog with an adopter user
* Organization staff can filter their applications and dogs to make searching easier
* Mailer sends an email to organization staff for any new adoption requests on their dogs
* Mailer sends admin an email when a new staff registration occurs
* Mailer sends new adopters a welcome email
* Authorizations to control the actions of users i.e. only adopters can apply to adopt dogs and only verified staff can carry out staff actions.
* Forms make use of Stimulus Javascript framework to provide features like conditional fields and character counters.

The whole site is styled using Bootstrap 5.

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


**Timelines**

The dog adoption process is seasonal and busy times usually run from November to June. As such, we aim to have the MVP running in production by November 1, 2022.


**Contributions**

I am currently working with one front-end developer who has done amazing work to create wireframing and prototyping for the application. They are also helping with styling the front-end. 

My desire is to take on more contributors to refactor code and add additional features after the MVP is up and running in November, 2022. If you are a rails dev who would like to contribute to this project, please let me know.


**Unit Testing**

I am currently working on writing unit tests for system testing. Admittedly, this application was not built with test driven development, and tests are being written after the fact. This is something I would change if I was to do it again, as implementing testing from the start is clearly beneficial and reinforces good code practices.


**Local Setup**

To set this application up locally:
* `rails -v` to ensure you have Rails 7.0.3 installed
* `ruby -v` to ensure you have Ruby version 3.0.3 or later installed
* `psql --version` to ensure you have PostgreSQL 12.12 installed (make sure you have a user and password)
* Fork the repository and copy SSH key
* `git clone <'SSH Key'>` to download application locally
* `bundle install` to install gems (you may have to change gem 'sassc-rails' to gem 'sassc', "~> 2.1.0")
* `bundle exec install figaro` 
* add your PostgreSQL database username and database password to `config/application.yml` as ENV variables
* `rails db:migrate` to run all migrations
* `rails db:seed` to load seed data
* `rails s` to run the local server
* 'localhost:3000' in browser to access the application
