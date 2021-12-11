# Spike's To-Do - Creating a to-do app that's intuitive and powerful
## Links
- [App on Heroku](https://ancient-wave-58090.herokuapp.com/)

## Getting Started - Contributing
Before working on code, install dependencies. 

```bash
$ bundle config without production
$ bundle install
```

## Commits, Branches, and Pull Requests   
### To work on a feature
1. Pull 
   - `$ git pull` 
2. Create a branch for the feature if there is not one already                                   
   - `$ git branch  [feature branch name]`
   - `$ git checkout [feature branch name]`
3. Make a working branch for your code based off of the feature branch 
   - `$ git branch  [working branch name]`
   - `$ git checkout [working branch name]`
4. Code on the working branch
5. Commit your changes
   - `$ git add -A`
   - `$ git commit -m "[your commit message. include a # issue number to link it]"`
5. Merge your working with the feature branch
   - `$ git checkout [feature branch name]`
   - `$ git merge [working branch name]`
   - If there are merge conflicts, manually change the files listed under "merge" and commit changes
6. When the feature is done, merge it with main.
   - Make sure main is up to date.
      - `$ git checkout main`
      - `$ git pull`
   - Merge main with your feature branch.
      - `$ git checkout [feature branch name]`
      - `$ git checkout [feature branch name]`
      - Double-check that it's up to date: `$ git pull`
      - `$ git merge main`
      - Resolve any merge conflicts. Make sure tests pass before submitting a PR.
8. Push local feature branch to remote.
   - `$ git checkout [feature branch name]`
   - `$ git push origin [feature branch name]`
9. To merge to main, on GitHub, click pull request button on code page and submit a pull request.
   - Link the issue to the PR so that when the PR is closed, the issue is as well.
11. Moniter the PR and make any changes necessary! Thank you for helping!! ✨

### To test your feature
#### Install Selenium drivers for JS tests

This should support the selenium-headless driver in WSL. If you want to use another driver for your tests, change the JS driver in `spec/rails_helper.rb` (`Capybara.javascript_driver = :selenium_headless`) and make sure you install the necessary driver. Going forward, don't manually set the driver in tests, just specify that `JS: true` in the header and it will use the driver you specify in `rails_helper.rb`.

**Step 0:** First try running the tests after bundle installing with the webdrivers gem. Try running `$ rails spec` and if you get a "binary not found" error for the tests with JS, proceed with the steps below. If not, the webdrivers gem is working correctly and you're good to go.

:exclamation: If you don't have permission during any of these steps, prefix the command with sudo

##### Option 1: Apt on WSL
1. Install geckodriver using apt `$ apt install firefox-geckodriver`
2. Try running `$ rails spec`. If it doesn't work, continue with step 3. If it doesn't, you're done!
3. Install Firefox: `$ apt install firefox`
4. Try running `$ rails spec` again. If you get an error about binaries not being found, something didn't work -- Try option 2. Otherwise, you're done!


##### Option 2: Node on Mac
1. Install Firefox
2. Install Node
   a. Via nvm:
      a1. Install Node version manager (nvm): `$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash`
      a2. Install Node (npm): `$ nvm install node`
      a3. Exit and restart the terminal. 
      a4. If `$ npm -v` doesn't return a version number, try installing via apt
   b. Via apt:
      b1. `$ apt install npm`
      b2. Exit and restart the terminal
      b3. Make sure `$ npm -v` returns a version number
3. Install webdriver manager: `$ npm install -g webdriver-manager`
4. Use webdriver manager to install current webdrivers: `$ webdriver-manager update`
5. Run `$ rails spec` in our app. If you don't get an error about binaries not being found, you're done. If you do, something didn't work.

#### Run tests
5. `$ rails spec`

### Commits 
Make sure your commit messages are descriptive, and in the present tense (per convention)
- Example (using active voice)
 ```
   // Bad:
   I created a card component and added the rainbow as well as updated the image size

   // Good:
   Create card component
     - add rainbow bar
     - update image size
 ```
 - Your commit message should look like a list of instructions
