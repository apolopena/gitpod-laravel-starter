# [Laravel Gitpod Starter] 
🚀
This a Laravel 8 starter project designed as a starting point for you. Once you have properly copied this repository you may add and change the codebase to your hearts desire 💞. You may also want to save any of the information you find useful on this README page before you overwrite it with information about your own project, the project that this codebase will become 🤩.

This project is designed to run and be developed in a [Gitpod](https://gitpod.io/) environment but can be deployed and developed locally. See the **local development outside of Gitpod** section for more details. Live deployment of this project can of course be done anywhere and that is up to you. The project will be running live on Gitpod, however the project only stays open for a small amount of time (usually 30 minutes) which is counted against your Gitpod account hours. A free Gitpod account gets you 50 hours of workspace time a week.

### Requirements ###
- A [Github](https://github.com/) account (a free account is fine).
- A [GitPod](https://www.gitpod.io/) account (a free account is fine)

## Setting Up ##
Gitpod will use the name of Github repository you use as the name of the project so make sure you name your new repository accordingly. There are many ways to copy a repository, blast away the history and name it something new and call it your own. Here is a guide you can follow if you like.

---
### Tl;dr ###
**Step 1**: In your browser on Github make a new repository.
**Step 2**: On your local machine run these commands in your shell. Ensure that the NEW_PROJECT_REPO_NAME matches the name of the repository you created in step 1.git add -A
```bash
mkdir NEW_PROJECT_REPO_NAME
cd NEW_PROJECT_REPO_NAME
git clone https://github.com/apolopena/gitpod-laravel8-starter.git .
rm -rf .git
git init
git add -A
git commit -m "initial commit built from https://github.com/apolopena/gitpod-laravel8-starter"
git remote add origin https://github.com/GITHUB_USERNAME/NEW_PROJECT_REPO_NAME.git
git branch -m main
git push -u origin main
```
---

*Or read on for a more detailed explanation of the recommended steps.*
- First copy this Github repository into a new Github repository of your own and of course be sure to name that repository as the name of your project. These instructions assume you have a bash or bash like shell to work with but if you dont you can figure out on your own.
  1. In a web browser, [make a new repository in github](https://docs.github.com/en/github/getting-started-with-github/create-a-repo).
  2. On your local machine create a directory that has the *same name* as your newly created repository in the previous step. For the sake of instruction lets say you named the repo NEW_PROJECT_REPO_NAME.
    - `mkdir NEW_PROJECT_REPO_NAME`
  3. Move into your newly created local folder.
    - `cd NEW_PROJECT_REPO_NAME`
  4. Clone this repository into your newly created local folder. Pay close attention to the *.* at the end of this command as you do not want and extra folder named gitpod-laravel8-starter in your project repo. You may use the SSH URL is you like. This example uses the https URL.
    - `git clone https://github.com/apolopena/gitpod-laravel8-starter.git .`
  5. Delete all the git history (important step).
    - `rm -rf .git`
  6. Initialize the local git repository.
    - `git init`
  7. Add all the files to the local git repository.
    - `git add -A`
  8. Commit all the files to the local git repository.
    - `git commit -m "initial commit built from https://github.com/apolopena/gitpod-laravel8-starter"`
  9. Add the URL for the remote repository where your local repository will be pushed to. You can use SSH or HTTPS. This example uses https. If you don't know how to find the remote URL for your repository you read [this](https://checkmarx.atlassian.net/wiki/spaces/KC/pages/131432811/GitHub+-+Tips+on+Finding+Git+GitHub+Repository+URLs#:~:text=Tip%20to%20find%20the%20Github,link%20as%20a%20regular%20URL.).
    - The command will look something like this:
      - `git remote add origin https://github.com/<github user name>/NEW_PROJECT_REPO_NAME.git`
  10. Create the local main branch. NOTE: main branches are now called `main` and are no longer called `master`.
    - `git branch -m main`
  11. Finally push your local repository main branch to the remote upsteam on the github servers.
    - `git push -u origin main`


- Secondly you need to build out the Gitpod workspace for the first time. Gitpod makes this easy. One simple URL builds out the whole thing. Lets call this URL the Gitpod workspace build URL.
  1. Paste URL your newly created github repository to the end of the special Gitpod URL, **https://gitpod.io/#/**.
    - For example if your respoitory url is **https://github.com/myusername/myprojectname** then the Gitpod workspace build URL needs to look like this: 
      - **https://gitpod.io/#/https://github.com/myusername/myprojectname**
- Finally build out the Gitpod workspace by pasting the Gitpod you obtained in the previous step into your browser and hit enter.
  1. The first time around and entire online development environment comeplete with and IDE is being built from a custom docker container so this will take some time. Scaffolding for the laravel 8 project and debugging capabilities are also created the first time you build the workspace so it will be up to you to commit those newly created files to your repository once you see that the build was successful. more on that below
  2. Gitpod will cache subsequent requests to your workspace and when you restart the workspace it will be much quicker than the inital build so don't worry.

## Running the client ##
A preview browser should automatically open and display the Laravel start page. This page is being served by a web server. The code for this page is in `/resources/views/welcome.blade.php` Please read the [Gitpod documentation](https://www.gitpod.io/docs/) if you want to use this amazing system to its fullest potential. In the IDE there is a UI for hiding the preview brower panel and for launching the preview browser in a seperate window. Look on the right side area of the IDE for these controls.

## Pushing files ##
If the results log shows success, you should push the newly created project files to your remote repository. *If you do not push the newly created project files to your remote repository **all** of those will be **lost** when the workspace stops and is restarted!*. 

A successful results log will look something like this:
```
Results of building the workspace image ➥
BEGIN: update composer
  Purging existing version of composer: Composer 1.10.1 2020-03-13 20:34:27
  SUCCESS: purged existing version of composer.
  Installing latest version of composer...
  SUCCESS: latest version of composer installed: Composer version 2.0.8 2020-12-03 17:20:38
END: update composer
BEGIN: Scaffolding Laravel Project
  Creating Laravel 8.x project in ~/temp-app ...
  SUCCESS: Laravel Framework 8.24.0 project temp-app project created in ~/
END: Scaffolding Laravel Project

Moving Laravel project from ~/temp-app to /workspace/gitpod-laravel8-starter ...
SUCCESS: moved Laravel project from ~/temp-app to /workspace/gitpod-laravel8-starter
If the above results are successful then make sure to add, commit and push the changes to your git repository.
```


### Debugging (TBD, not accurate yet)

The server is started in way that is compatible with `xdebug` for you via a command task set in .gitpod.yml

**Debugging must be enabled before breakpoints can be hit and will last for an hour before it is disabled automatically.**
To enable debugging run `debug-on` in a Gitpod terminal. 
To disable debugging run `debug-off` in a Gitpod terminal.

*Note*: When debugging is enabled or disabled the preview browser will reload the index page. When debugging is enabled *each* subsequent request can be debugged for an hour or until debugging is disabled.

*Additional Note*: This system uses port 9009 for the debugging. A launch configuration file is included (`/.theia/launch.json`).

- Once the preview browser is open, set a breakpoint by clicking in the gutter next to the line of code you want in any `php` file in the `public` folder (or deeper) and then in the Gitpod (THEIA) IDE in the browser:
  2. Hit the debug icon in the left side panel to open the Debug panel.
  3. Choose "Listen for XDebug" from the dropdown list.
  4. Hit the green play button (you should see the status "RUNNING" in the Threads panel)
  5. Refresh the preview browser and you should now hit your breakpoint.


All debugging is subject to server timeout, refreshing the preview browser should make this go away.


You may also debug blade templates by placing the following snippet above where you want to inspect the blade directive.
```php
<?php xdebug_break(); ?>
```
Save the file and refresh the preview browser when the debugger is in the IDE. If all else fails stop the debugger, launch the "Listen for Xdebug" launch configuration again and refresh the preview browser.
This will open a temporary php file that has all the blade directives convert to php tags, you may set additional breakpoints in this code as well.

### Tailing the xdebug log
To tail the xdbug log
  1. Open a new terminal in gitpod
  2. Run the command: `tail -f /var/log/xdebug.log`

### Local Development Outside of Gitpod ###
For now this will be something you need to figure out. Eventually some guidelines for how to do that with vscode will be added here.

*Thanks to the gitpod community and xdebug!
