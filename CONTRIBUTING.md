# Contributing
[code of conduct]: https://github.com/rubyforgood/code-of-conduct
[open issue]: https://github.com/orgs/rubyforgood/projects/10/views/1
[set up instructions]: https://github.com/rubyforgood/pet-rescue#local-setup

We ♥ contributors! By participating in this project, you agree to abide by the
Ruby for Good [code of conduct].

Here are the basic steps to submit a pull request. Make sure that you're working
on an [open issue]–if the relevant issue doesn't exist, open it!

#### 1. Set up your local environment using these [set up instructions][set up instructions].

#### 2. Claim an issue on [our issue tracker][open issue] 
Assign it to yourself (core team member) or add a comment. If the issue doesn't exist yet, open it.

#### 3. Fork the repo.
* Clone your forked repo to your local machine `git clone <ssh or https url>`
* Set the upstream remote so you can stay synced with this repo `git remote add upstream <ssh or https url>`
* Create a branch on your forked repo `git checkout -b <branch name>`
* Add commits of discreet units of code along with descriptive commit messages
* Sync your forked repo and branch with this repo periodically following [this flow](https://www.theodinproject.com/lessons/ruby-using-git-in-the-real-world#ongoing-workflow)

#### 4. Run the tests. 
We only take pull requests with passing tests, and it's great to know that you have a clean slate: `bundle exec rake`

#### 5. Add a test for your change. 
If you are adding functionality or fixing a bug, you should add a test!

#### 6. Make the test pass.

#### 7. Push to your fork and submit a pull request. 

* Push your branch to your forked repo `git push origin <branch name>`
* Go to your forked repo on GitHub and make a pull request.
* Ensure the description of the PR explains what your code does and includes the issue number (ex. `Resolves #1`). If it is a UI change, include a screenshot.
* Only commit relevant code/files.* Push your branch to your forked repo `git push origin <branch name>`
* Go to your forked repo on GitHub and make a pull request.
* Ensure the description of the PR explains what your code does. If it is a UI change, include a screenshot.
* Only commit relevant code/files.

At this point you're waiting on us–we'll try to respond to your PR quickly.
We may suggest some changes or improvements or alternatives.

Some things that will increase the chance that your pull request is accepted:

* Use Rails idioms and helpers
* Include tests that fail without your code, and pass with it
* Update the documentation, the surrounding one, examples elsewhere, guides,
  whatever is affected by your contribution