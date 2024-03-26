# Pet Rescue Adoption Application
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-24-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

The Pet Rescue app is derived from the [Baja Pet Rescue Dog Adoption Application](https://github.com/kasugaijin/baja-pet-rescue/tree/main) created by @kasugaijin who wanted to give back to the grassroots organization from where he adopted his dog in Mexico by building them a web application. Pet Rescue is an application that makes it easy to link adopters with pets.

---

# 🚀 Getting Started

Let's get your machine setup to startup the application!

## Prerequisites

⚠️  We assume you already have ruby installed with your preferred version manager. This codebase supports [rbenv](
https://github.com/rbenv/rbenv) and [asdf](https://github.com/asdf-vm/asdf-ruby).

## 🤝 Contributing Guidelines 

Please feel free to contribute! Priority will be given to pull requests that address outstanding issues and have appropriate test coverage. Focus on issues tagged with the next milestone for higher priority.

To contribute:
* Identify an unassigned issue
* Only work on one issue at a time
* Request assignment of an issue by adding a comment on the issue
* Fork the repo if you're not yet a contributor 
* Ensure that the application runs locally in your browser. When you run the test suite locally, it should pass
* Create a new branch for the issue using the format `XXX-brief-description-of-feature`, where `XXX` is the issue number
* Make code changes related to the assigned issue
* Commit locally using descriptive messages that indicate the affected parts of the application
* Add tests related to your work(most of the time)
* Ensure all tests pass successfully; if any fail, fix the issues causing the failures
* Make a final commit if any code changes are required
* Push up the branch
* Create a pull request and fill out the description fields
* We like to make sure people are recognized for their contributions, so please attribute others by commenting on a pull request with

  ```
  @all-contributors
  please add @<username> for <contributions>. 
  please add @<username> for <contributions>.
  ```
  Replace `<contributions>` with `code` or `review`

## Install & Setup

Clone the codebase 
```
git clone git@github.com:rubyforgood/pet-rescue.git
```

Create a new `config/application.yml` file from the `config/application.example.yml`:
```
cp config/application.example.yml config/application.yml
```

Update your `config/application.yml` by replacing the places that say REPLACE_ME.

Run the setup script to prepare DB and assets
```sh
bin/setup
```

To run the app locally, use:
```
bin/dev
```

You should see the seed organization by going to:
```
http://localhost:3000/alta/
```

## Login Credentials

All users are scoped to an organization. Hence, you must login via the correct
login portal per organization. 

You can use the following login credentials to login to http://localhost:3000/alta:

Use the following login 
Adopter 
- email: `adopter1@alta.com` 
- password: `123456`

Staff
- email: `staff@alta.com`
- password: `123456`


# 🧪 Running Tests

Run unit tests only
```
./bin/rails test
```

Run system tests only (Headless)
```
./bin/rails test:system
```

Run system tests only (Not-Headless)
```
CI=false ./bin/rails test:system
```

**Note:** If system tests are failing for you, try prepending the command with `APP_HOST=localhost`. Your host might be misconfigured.
```
APP_HOST=localhost ./bin/rails test:system
```

Run ALL tests:
```
./bin/rails test:all
```

# 💅 Linting 

We use [standard](https://github.com/standardrb/standard) for linting. It provides a command for auto-fixing errors:

```sh
rails standard:fix
```

# 🔨 Tools

This [google sheets](https://docs.google.com/spreadsheets/d/1kPDeLicDu1IFkjWEXrWpwT36jtvoMVopEBiX-5L-r1A/edit?usp=sharing) contains a list of tools, their purposes, and who has access to grant permissions.

# 📖 About

## Ruby for Good
Pet Rescue is one of many projects initiated and run by Ruby for Good. You can find out more about Ruby for Good at https://rubyforgood.org

## Pet Rescue Adoption Sites
[Baja Pet Rescue](https://www.bajapetrescue.com)

# 🌟 Core Values
While vision is the destination, and strategy is how we'll get there, core values are what we'll use to handle times of change or uncertainty (both of which are expected, guaranteed to happen, and positive signs of growth!).

We are committed to promoting positive culture and outcomes for all, from coders and maintainers and leads
to pet rescue and adoption administrators -- and animals everywhere.

We will lean on the following as guiding principles when interacting with others -- stakeholders, as well as current and future maintainers, leads, and collaborators -- and we ask that anyone engaging with this project in any capacity to do the same. Know that we do want to know how and when (not if) we can improve upon these values and/or the way in which we live by and act in accordance with them, so please comment here and in PRs when you have ideas.

Here are our core values defined by early contributors and leads:

### Code Quality and Collaboration
Write maintainable code that is accessible and enjoyable (for beginners and seasoned coders alike), supports and encourages contributors and their contributions, and ensures long-term sustainability of this project and the efforts it supports.

### Communication and Perspective:
Prioritize clear communication, embrace diverse viewpoints, and always engage feedback -- all with a commitment to timely responses and ongoing improvement for all. Rescue and adoption partner perspectives will be prioritized over abstracted conceptualization of their needs.

### Engagement and Practicality:
Build upon stakeholder partnerships to foster and encourage their active involvement, focusing constructive discussion and dispute resolution on the practical impact of our collective work.


---

# 📚Knowledge Base

## Preparation Work (Before code)
These are just some of the documents put together before writing any code:
* Slide deck to pitch idea to client: [here](https://docs.google.com/presentation/d/1d4gjzADk7BcxmQEVZlesheGUen9d1E3RzrVvskMhVxo/edit?usp=sharing)
* Figma site design: [here](https://www.figma.com/file/0jVgYASUJy0KiX3BVc3dFM/Tasks?type=design&node-id=0-1&mode=design)
* Model association diagram: [here](https://lucid.app/lucidchart/a915c03c-3c09-454d-837b-f3d2768f5722/edit?viewport_loc=-25%2C-973%2C3565%2C2341%2C0_0&invitationId=inv_85cf2967-7b33-4030-903f-9655e767cbbf)


## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/kasugaijin"><img src="https://avatars.githubusercontent.com/u/95949082?v=4?s=100" width="100px;" alt="Ben"/><br /><sub><b>Ben</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=kasugaijin" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/marlena-b"><img src="https://avatars.githubusercontent.com/u/96994176?v=4?s=100" width="100px;" alt="Marlena Borowiec"/><br /><sub><b>Marlena Borowiec</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=marlena-b" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/Ptrboro"><img src="https://avatars.githubusercontent.com/u/16762860?v=4?s=100" width="100px;" alt="Piotr Borowiec"/><br /><sub><b>Piotr Borowiec</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=Ptrboro" title="Code">💻</a> <a href="https://github.com/rubyforgood/pet-rescue/pulls?q=is%3Apr+reviewed-by%3APtrboro" title="Reviewed Pull Requests">👀</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/yuricarvalhop"><img src="https://avatars.githubusercontent.com/u/20230045?v=4?s=100" width="100px;" alt="Yuri Pains"/><br /><sub><b>Yuri Pains</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=yuricarvalhop" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://reyes-dev.github.io/portfolio-site/"><img src="https://avatars.githubusercontent.com/u/102765102?v=4?s=100" width="100px;" alt="Jarrod Reyes"/><br /><sub><b>Jarrod Reyes</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=reyes-dev" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://erinclaudio.com"><img src="https://avatars.githubusercontent.com/u/20326770?v=4?s=100" width="100px;" alt="Erin Claudio"/><br /><sub><b>Erin Claudio</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=ErinClaudio" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://edwinmak.com"><img src="https://avatars.githubusercontent.com/u/11335191?v=4?s=100" width="100px;" alt="Edwin Mak"/><br /><sub><b>Edwin Mak</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=edwinthinks" title="Code">💻</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/jadekstewart3"><img src="https://avatars.githubusercontent.com/u/114014697?v=4?s=100" width="100px;" alt="Jade Stewart"/><br /><sub><b>Jade Stewart</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=jadekstewart3" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://vernespendic.com"><img src="https://avatars.githubusercontent.com/u/31761693?v=4?s=100" width="100px;" alt="Vernes"/><br /><sub><b>Vernes</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=BakiVernes" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://marchandmd.github.io"><img src="https://avatars.githubusercontent.com/u/35391349?v=4?s=100" width="100px;" alt="Michael Marchand"/><br /><sub><b>Michael Marchand</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=MarchandMD" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/Yuji3000"><img src="https://avatars.githubusercontent.com/u/108035840?v=4?s=100" width="100px;" alt="Yuji K."/><br /><sub><b>Yuji K.</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=Yuji3000" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/jmilljr24"><img src="https://avatars.githubusercontent.com/u/16829344?v=4?s=100" width="100px;" alt="Justin"/><br /><sub><b>Justin</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=jmilljr24" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/gorangorun"><img src="https://avatars.githubusercontent.com/u/89098560?v=4?s=100" width="100px;" alt="Goran"/><br /><sub><b>Goran</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=gorangorun" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/phonghpham"><img src="https://avatars.githubusercontent.com/u/9318603?v=4?s=100" width="100px;" alt="Phong Pham"/><br /><sub><b>Phong Pham</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=phonghpham" title="Code">💻</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://dev.to/diegolinhares"><img src="https://avatars.githubusercontent.com/u/3309779?v=4?s=100" width="100px;" alt="Diego Linhares"/><br /><sub><b>Diego Linhares</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=diegolinhares" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://egemen-dev.github.io/portfolio"><img src="https://avatars.githubusercontent.com/u/93445248?v=4?s=100" width="100px;" alt="Egemen Öztürk"/><br /><sub><b>Egemen Öztürk</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=egemen-dev" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/MooseCowBear"><img src="https://avatars.githubusercontent.com/u/82609260?v=4?s=100" width="100px;" alt="Alisa"/><br /><sub><b>Alisa</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=MooseCowBear" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/nsiwnf"><img src="https://avatars.githubusercontent.com/u/34173394?v=4?s=100" width="100px;" alt="Sree P"/><br /><sub><b>Sree P</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=nsiwnf" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/Thrillberg"><img src="https://avatars.githubusercontent.com/u/10481391?v=4?s=100" width="100px;" alt="Eric Tillberg"/><br /><sub><b>Eric Tillberg</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=Thrillberg" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/Tomaszabc"><img src="https://avatars.githubusercontent.com/u/131488886?v=4?s=100" width="100px;" alt="Tomaszabc"/><br /><sub><b>Tomaszabc</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=Tomaszabc" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/atbalaji"><img src="https://avatars.githubusercontent.com/u/18101543?v=4?s=100" width="100px;" alt="BALAJI . A . T "/><br /><sub><b>BALAJI . A . T </b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=atbalaji" title="Code">💻</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/mononoken"><img src="https://avatars.githubusercontent.com/u/81536479?v=4?s=100" width="100px;" alt="Ken Maeshima"/><br /><sub><b>Ken Maeshima</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=mononoken" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://mason-roberts.dev"><img src="https://avatars.githubusercontent.com/u/44660994?v=4?s=100" width="100px;" alt="Mason Roberts"/><br /><sub><b>Mason Roberts</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=Developer3027" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://portfolio-1hab.onrender.com/"><img src="https://avatars.githubusercontent.com/u/61897123?v=4?s=100" width="100px;" alt="Mayank Bhatt"/><br /><sub><b>Mayank Bhatt</b></sub></a><br /><a href="https://github.com/rubyforgood/pet-rescue/commits?author=mayankbhatt07141" title="Code">💻</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!

