# Baja Pet Rescue Dog Adoption Application

I am a self-taught web developer and this is my first production Ruby on Rails application with a real user base. I love coding, and I love my dog. So, I wanted to give back to the grassroots organization where I adopted my dog from in Mexico by building them a web application to make their process of linking adopters with dogs easier.

This application has been very successful so far, enabling 41 adoptions in its first 6 months. However, I still have a lot to learn and always appreciate feedback. My curiosity for learning led me to provide this codebase to Jason Swett from Code with Jason to review on his live webinar twice in 2023 (so far). Thank you Jason! It was a great experience to learn from you and others on the call about how the code could be refactored for improvement. 

- [general code review](https://youtu.be/0Otyx30pfzY)
- [test suite code review](https://www.youtube.com/watch?v=AD5Sg-CKgww)


Live Site: [Baja Pet Rescue](https://www.bajapetrescue.com)


### The Problem

The dog rescue organization has limited time and resources. They have been using Facebook and Instagram to post new dogs and get interest from adopters. This has been working, but is not ideal because:
* Staff are forced to use the platform's layout for dog posts
* Staff have a hard time keeping track of applications for each dog
* Staff have to use a third party adoption application form
* Staff have insufficient resources to build/maintain a website
* There are no free, 'off the shelf' CMS solutions available for this domain
* There is limited ability to customise or brand online presence and build credibility
* Adopters have to duplicate efforts each time they apply to adopt a dog
* Adopters have no easy way to check the status of their application
* Adopters have to use a patchwork process comprised of different apps
* Adopters have to be registered on a social media platform and know how to navigate it


### The Solution

I met with the stakeholders to learn about their challenges and needs and then conceptualized a solution to address the above challenges. This was a great exercise in turning business needs into application logic. 

The solution had to be simple, easy to maintain and manage, and provide a more cohesive flow and experience for both staff and adopters alike. It had to make use of out of the box technology with a low monthly overhead.

I decided that a Ruby on Rails application would be a suitable technology because it enables rapid development and its REST framework provides all of the required functionality. I chose a PostgreSQL database because it is robust and works readily with Ruby on Rails and Heroku, where the production application lives. Last, I opted to use the SendGrid app on Heroku to manage SMTP for mail, and Amazon S3 for image hosting.

#### Preparation Work (Before code)
These are just some of the documents put together before writing any code:
* Slide deck to pitch idea to client: [here](https://docs.google.com/presentation/d/1d4gjzADk7BcxmQEVZlesheGUen9d1E3RzrVvskMhVxo/edit?usp=sharing)
* Figma site design: [here](https://www.figma.com/file/x3iM31l8csY7mT0VwKykhT/BPR---Wireframes---Ami?node-id=530186%3A154&t=mgRlseVd2LTKPX4o-1)
* Model association diagram: [here](https://lucid.app/lucidchart/a915c03c-3c09-454d-837b-f3d2768f5722/edit?viewport_loc=-25%2C-973%2C3565%2C2341%2C0_0&invitationId=inv_85cf2967-7b33-4030-903f-9655e767cbbf)

#### Features

The application has the following features:
* Authentication for two user types - adopters and organization staff
* Organization staff can perform CRUD actions on dogs on behalf of an organization
* Active Storage for image uploads
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
* Forms make use of Stimulus JavaScript framework to provide features like conditional fields and character counters.
* Styling is achieved using Bootstrap 5
* Model associations and tables allow for scalability such that multiple organizations could operate under this application, each with control over their own dogs.
* Successes page that uses Google Map API to display an interactive map with a pin for each adopted dog's new home around the world. [See Project](https://github.com/users/kasugaijin/projects/1/settings)
* 95% test coverage

#### To Do

* See [issues tab](https://github.com/kasugaijin/baja-pet-rescue/issues). 

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



### Contributions

This project has benefited from front and back end contributions. More contributors of all skill levels are welcome. 

Picking up an issue:
* Check the Issues tab for a list of work that needs completing.
* If you are interested in an issue and it is unassigned, leave a comment on the issue to claim it, then I will assign it to you.
* Please take only one issue at a time i.e., pick up the next issue after your current PR is merged and the issue is closed.
* If you are working on tests, refer to [this issue](https://github.com/kasugaijin/baja-pet-rescue/issues/149), particularly the May 17 comment
for details on some testing best practice. These are not laws, but should be good guidance.

Making Pull Requests:
* Fork this repo to your own GitHub account
* Clone your forked repo to your local machine `git clone <ssh or https url>`
* Set the upstream remote so you can stay synced with this repo `git remote add upstream <ssh or https url>`
* Create a branch on your forked repo `git checkout -b <branch name>`
* Add commits of discreet units of code along with descriptive commit messages
* Sync your forked repo and branch with this repo periodically following [this flow](https://www.theodinproject.com/lessons/ruby-using-git-in-the-real-world#ongoing-workflow)
* Push your branch to your forked repo `git push origin <branch name>`
* Go to your forked repo on GitHub and make a pull request.
* Ensure the description of the PR explains what your code does. If it is a UI change, include a screenshot. 
* Only commit relevant code/files.
* Make sure the full test suite passes by running `rails test:all`.

When you make a pull request, the GitHub Actions pipeline will run the test suite against your changes and will notify you of pass or fail. You can check the logs for errors, if any. Once the pipeline passes, your pull request will be reviewed and there may be feedback or questions related to your code, so please be prepared to follow up on those. Pull requests are usually reviewed daily.
add bullets to the beginning of this set of instructions for an open source github repo for making contributions, and make sure the bullets achieve the

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

### Design Considerations
As I spend more time in Rails and reading about design best practices, one glaring oversight I made in the initial design of this application was not scoping resources (routes and controllers) accordingly. All of my routes and controllers are top level. It works, but if this application were to grow and become more complex, there would be benefit to scoping. For example, the organization_dogs controller should be scoped under an organization, and an adopter profile scoped under an adopter account. This would provide multiple benefits, including: 
- URL namespaces that are more intuitive re the structure of the application e.g., `/organization/dogs` is far more intuitive in terms of understanding these dogs belong to a given organization compared to `/dogs` which is configured to point to the `organization_dogs#index` controller action.
- Developer ergonomics would be improved and the structure of the application more easily grasped. This improves maintainability.
- Encapsulation of controller logic would help prevent naming conflicts and reduce the chance of unintended consequences.
