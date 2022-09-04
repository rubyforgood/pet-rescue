# Dog Adoption App

I am a self-taught web developer and this is my first production Ruby on Rails application. I love coding, and I love my dog. So, I wanted to give back to the grassroots organization where I adopted my dog from in Mexico by building them a web application to make the process of linking adopters with dogs easier.

**The Problem**
The dog resuce organization has limited time and resources. They have been using Facebook and Instagram to post new dogs and get interest from adopters. This has been working, but is not ideal because:
* staff have to create dog posts that conform to the given platform format
* staff have challenges keeping track of applications for each dog
* staff have to manage/use a third party adoption application form (Google Forms)
* staff want a website but have limited time and technical capacity
* adopters have to fill in a form each time they apply to adopt a dog
* adopters have no easy way to check the status of their application
* adopters have to be registered on a platform and know how to navigate it (think non-technical boomer trying to learn instagram)
* there is limited ability to brand online presence and build credibility

**The Solution**
After a few meetings with the stakeholder to learn about their challenges and needs I was able to conceptualize a solution that will require minimal technical maintenance by organization staff, and more importantly, make their work more efficient.

I decided that a ruby on rails application would be a suitable technology because it enables rapid development and the required features fit within a RESTful framework. 

The application has the following features:
* Authentication for two user types - adopters and organization staff
* Organization staff can perform CRUD actions on dogs on behalf of an organization
* Adopters can create, read and update their profile, which contains vetting information
* Adopters can create adoption applications for a dog and view their application history/status
* Organization staff can review application requests for a dog and set a status
* Organization staff can create adoptions linking a dog with an adopter user
* Mailer sends an email to organization staff for any new adoption requests on their dogs
* Mailer sends admin an email when a new staff registration occurs
* Mailer sends new adopters a welcome email

The back end uses PostgreSQL, aligned with that used by Heroku for deployment.
Front end uses Bootstrap 5 and Stimulus JS.

*Gems*
* Devise
* Figaro
* Bootstrap CSS
* Better errors
* Guard and Guard live reload
* Letter opener
* Active Storage Validations
* Phone lib
