# Spike's To-Do - Creating a to-do app that's intuitive and powerful
## [Documentation](https://docs.google.com/document/d/1sRqvjrhXCQqVU--eE-5izc8l61-ruSX7MC8zW1Kevcs/edit#heading=h.lpem5zhmyz2k)
## Getting Started

```bash
   bundle config without production
   bundle install
```

## Commits, Branches, and Pull Requests
- Note: Make sure your commit messages are descriptive, and in the present tense (per convention)
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
6. To push to main when feature is done, push local feature branch to remote
   - `$ git checkout [feature branch name]`
   - `$ git push origin [feature branch name]`
7. On GitHub, click pull request button on code page and submit PR
8. If there is a merge conflict...
   - I think merge the main branch with the feature branch and push to remote feature branch

![](mascot.jpg)
