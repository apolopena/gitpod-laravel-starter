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
**Step 2**: On your local machine run these commands in your shell. Ensure that the NEW_PROJECT_REPO_NAME matches the name of the repository you created in step 1.
```bash
mkdir NEW_PROJECT_REPO_NAME
cd NEW_PROJECT_REPO_NAME
git clone https://github.com/apolopena/gitpod-laravel8-starter.git
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
    - `git clone https://github.com/apolopena/gitpod-laravel8-starter.git`
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

## Running it ##
Here is a quick guide on how to view the starting page of your project in a preview browser. Please read the [Gitpod documentation](https://www.gitpod.io/docs/) if you want to use this amazing system to its fullest potential.


Once the gitpod workspace has been built and loaded you will see a log of the results in a terminal window at the bottom. The starting page of your project should be displayed in the preview browser. The preview browser can also be launched in a seperate window if you like. If you see that the starting page has not loaded in the preview browser try clicking the "try again" button as sometimes the preview window opens before the webserver has served the page.


### Debugging (TBD, not accurate yet)

 The server is started for you via the task set in .gitpod.yml but you may also startup a debugging session manually (for all php files in the public folder) by running the command: `php -S localhost:8080 -t public/`

 Note: This system uses port 9009 for the debugging data. A vs code launch configuration file is included (`/.theia/launch.json`).

- Once the preview browser is open, set a breakpoint in any `php` file in the `public` folder (or deeper) and then in the VScode IDE in the browser :
  2. Hit the debug icon in the left side panel to open the Debug panel.
  3. Choose "Listen for XDebug" from the dropdown list.
  4. Hit the green play button (you should see the status "RUNNING" in the Threads panel)
  5. Refresh the preview browser and you should now hit your breakpoint.

### Tailing the xdebug log
To tail the xdbug log
  1. Open a new terminal in gitpod
  2. Run the command: `tail -f /var/log/xdebug.log`

### Local Development Outside of Gitpod ###
For now this will be something you need to figure out. Eventually some guidelines for how to do that with vscode will be added here.

*Thanks to the gitpod community and xdebug!
