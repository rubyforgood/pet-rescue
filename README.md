# Dog Adoption App

Baja Pet Rescue is a grassroots organization in Mexico that finds stray dogs and rehomes them with adopters in USA and Canada. This is the organization I got my dog through, and I wanted to give back to them by building a fully functional web application to facilitate the adoption process.

I am a self-taught web developer and I wanted a project to showcase what I can build. I decided to  build this application to minimum viable product by myself, and then open up to other contributors to expand on the features. 

This application is built in Ruby on Rails and has the following features:
* Authentication for two user types - adopters and organization staff
* Organization staff can perform CRUD actions on dogs on behalf of an organization
* Adopters can create, read and update their profile, which contains vetting information
* Adopters can create adoption applications for a dog and view their application history/status
* Organization staff can review application requests for a dog and set a status
* Organization staff can create adoptions linking a dog with an adopter user
* Mailer sends an email to organization staff for any new adoption requests on their dogs
* Admin User that vets staff registrations and creates news organizations
* Mailer sends admin an email when a new staff registration occurs

The back end uses PostgreSQL, aligned with that used by Heroku for deployment.
Front end uses Bootstrap 5 and Stimulus JS.

*Gems*
* Devise for authentication
* Figaro for secure database authentication
* Bootstrap CSS
* Better errors
* Guard and Guard live reload
