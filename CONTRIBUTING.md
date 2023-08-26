# Contributing
[code of conduct]: https://github.com/rubyforgood/code-of-conduct
[open issue]: https://github.com/rubyforgood/pet-rescue/issues?q=is%3Aissue+is%3Aopen+no%3Aassignee
[set up instructions]: https://github.com/rubyforgood/pet-rescue#local-setup

We ♥ contributors! By participating in this project, you agree to abide by the
Ruby for Good [code of conduct].

If you need help with any steps in the process, feel free to slap a Help Wanted label on your issue or pull request and we'll try to provide assistance.

Here are the basic steps to submit a pull request. Make sure that you're working
on an [open issue]–if the relevant issue doesn't exist, open it!

#### 1. Set up your local environment using these [set up instructions][set up instructions].

#### 2. Claim an issue on [our issue tracker][open issue] 
Assign it to yourself (core team member) or add a comment. If the issue doesn't exist yet, open it.

#### 3. Clone the repo.
* Clone the repo to your local machine `git clone <ssh or https url>`
* Set the upstream remote so you can stay synced with this repo `git remote add upstream <ssh or https url>`
* Create a branch for your change `git checkout -b <branch name>`
* Add commits of discreet units of code along with descriptive commit messages
* Sync your branch with the `main` branch periodically

#### 4. Run the tests. 
We only take pull requests with passing tests, and it's great to know that you have a clean slate: `bundle exec rake`

#### 5. Add a test for your change. 
If you are adding functionality or fixing a bug, you should add a test!

#### 6. Make the test pass.

#### 7. Push to your change and submit a pull request. 

* Push your branch `git push origin <branch name>`
* Go to the project on GitHub and make a pull request.
* Ensure the description of the PR explains what your code does and includes the issue number (ex. `Resolves #1`). If it is a UI change, include a screenshot.
* Only commit relevant code/files.

At this point you're waiting on us–we'll try to respond to your PR quickly.
We may suggest some changes or improvements or alternatives.

Some things that will increase the chance that your pull request is accepted:

* Use Rails idioms and helpers
* Include tests that fail without your code, and pass with it
* Update the documentation, the surrounding one, examples elsewhere, guides,
  whatever is affected by your contribution

#### 8. Merge your code

If your PR gains an approval ✅ then you're free to merge it yourself! After doing a little celebratory dance, please resolve any merge conflicts that may have arisen, and merge into `main`!