# Laravel 8 Gitpod Starter

🚀
This a Laravel 8 starter project designed as a starting point for you. Once you have properly copied this repository you may add and change the codebase to your hearts desire 💞. You may also want to save any of the information you find useful on this README page before you overwrite it with information about your own project.

[![Try it out on on Gitpod.io](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://github.com/apolopena/gitpod-laravel8-starter) with [![emoji-log](https://cdn.rawgit.com/ahmadawais/stuff/ca97874/emoji-log/flat-round.svg)](https://github.com/ahmadawais/Emoji-Log/) built into the Gitpod environment.

This project is designed to run and be developed in a [Gitpod](https://gitpod.io/) environment but can be deployed and developed locally. See the **local development outside of Gitpod** section for more details. Live deployment of this project can of course be done anywhere and that is up to you. The project will be running live on Gitpod, however the project only stays open for a small amount of time (usually 30 minutes) which is counted against your Gitpod account hours. A free Gitpod account gets you 50 hours of workspace time a week.

### Requirements ###

- A [GitHub](https://github.com/) account (a free account is fine)

- A [GitPod](https://www.gitpod.io/) account (a free account is fine)

  

## Setting Up ##

Gitpod will use the name of GitHub repository you use as the name of the project so make sure you name your new repository accordingly. There are many ways to copy a repository, blast away the history and name it something new and call it your own. Here is a guide you can follow if you like.



---

### Tl;dr Quick Setup ###

1. Make a new repository from your GitHub account.
2. On your local machine run these commands in your shell. Ensure that the NEW_PROJECT_REPO_NAME matches the name of the repository you created in step 1. You can copy and paste these commands. You run these commands one at a time but make sure to omit the && at the end of each line.

```bash
mkdir NEW_PROJECT_REPO_NAME &&
cd NEW_PROJECT_REPO_NAME &&
git clone https://github.com/apolopena/gitpod-laravel8-starter.git . &&
rm -rf .git &&
git init &&
git add -A &&
git commit -m "initial commit built from https://github.com/apolopena/gitpod-laravel8-starter" &&
git remote add origin https://github.com/GITHUB_USERNAME/NEW_PROJECT_REPO_NAME.git &&
git branch -m main &&
git push -u origin main
```

---

***Or read on for a more detailed explanation of the recommended steps.***

- First copy this GitHub repository into a new GitHub repository of your own and of course be sure to name that repository as the name of your project. These instructions assume you have a bash or bash like shell to work with but if you dont you can figure out on your own.

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

  11. Finally push your local repository main branch to the remote upstream on the GitHub servers.

    - `git push -u origin main`


- Secondly you need to build out the Gitpod workspace for the first time. Gitpod makes this easy. One simple URL builds out the whole thing. Lets call this URL the Gitpod workspace build URL.

  1. Paste URL your newly created GitHub repository to the end of the special Gitpod URL, **https://gitpod.io/#/**.

    - For example if your repository URL is **https://github.com/myusername/myprojectname** then the Gitpod workspace build URL needs to look like this: 
      - **https://gitpod.io/#/https://github.com/myusername/myprojectname**

- Finally build out the Gitpod workspace by pasting the Gitpod you obtained in the previous step into your browser and hit enter.

  1. The first time around and entire online development environment complete with and IDE is being built from a custom docker container so this will take some time. Scaffolding for the Laravel 8 project and debugging capabilities are also created the first time you build the workspace so it will be up to you to commit those newly created files to your repository once you see that the build was successful. more on that below
  2. Gitpod will cache subsequent requests to your workspace and when you restart the workspace it will be much quicker than the initial build.
  3. 

## Running the client ##

A preview browser should automatically open and display the Laravel start page. This page is being served by the default web server. The code for this page is in `/resources/views/welcome.blade.php` Please read the [Gitpod documentation](https://www.gitpod.io/docs/) if you want to use this amazing system to its fullest potential. In the IDE there is a UI for hiding the preview browser panel and for launching the preview browser in a separate window. Look on the right side area of the IDE for these controls.



## Pushing files to your remote repository ##

If the results log shows success, you should push the newly created project files to your remote repository. 

*If you do not push the newly created project files to your remote repository they will be recreated every time you create a new Gitpod workspace.*



**Gitpod account permissions**

You may need to allow Gitpod additional permissions to push to your repository so if you come across an issue like [this one](https://community.gitpod.io/t/i-cant-push-my-changes-to-my-github-remote-repository/629), that is what you will need to do.



**GitHub email protection**

If your GitHub account uses the protected email feature and the email address you are using in your git configuration looks something like this:

`3366792+myusername@users.noreply.github.com`

you may encounter an error that looks something like this:

`! [remote rejected] readme-dev -> readme-dev (push declined due to email privacy restrictions)`

The easiest way to get past this error is to uncheck the box labeled "**Block command line pushes that expose my email**" under Settings-->Emails in your GitHub account.

If you don't want to do this then you can edit the `~/.gitconfig` file in your Gitpod workspace to use your protected email address as Gitpod defaults to using the unprotected email address for your GitHub account. Please note that if you do this you will have to make this change for __every_ workspace you create and that become cumbersome.



## Starter Project Configuration

This starter project is not fully opinionated.  You can control many aspects of the development environment and the Laravel project scaffolding. 

The file `starter.ini` in the root of the project allow you to configure optional installations and other configurations. See the comments in that file for what you can do. Simply change values in `starter.ini`, push those changes to your repo and create a new Gitpod workspace from that repo and your new configurations will be enabled.

The exception right now is the optional installation of `phpmyadmin`. This optional installation works however please see this [issue](https://github.com/apolopena/gitpod-laravel8-starter/issues/28) for more details.



### Development Servers

This starter project comes pre packaged with two development servers.

- Apache2
- PHP Development Sever

By default the server listed in `starter.ini` will be the server used. You can however run both servers at the same time or change your default sever. 

The default server will be started automatically when the workspace is started

You can toggle any server on and off from any terminal window by running the relevant command:

- Apache: `start_apache` or `stop_apache`
- PHP  built-in development server: `start_php_dev` or `stop_php_dev`



**Changing the default server**

Change the value of  `default_server` in the `development` section of `starter.ini` to either `php` or `apache`



**Running more than one server at a time**

You may start and stop multiple servers.

Lets say you have the Apache server running and you want to run the PHP development server at the same time just run this command:

`start_server php`

And now the PHP server will be running is parallel.



## Debugging

Debugging must be enabled before breakpoints can be hit and will last for an hour before the debug session is disabled automatically.

When debugging is enabled or disabled the preview browser will reload the index page. When debugging is enabled *each* subsequent request can be debugged for an hour or until debugging is disabled.

This system uses port `9009` for the debugging. A launch configuration file is included (`/.theia/launch.json`).



**The default development sever**

To enable a debugging session on the default development server run `debug-on` in a Gitpod terminal. 
To disable a debugging session on the default development server run `debug-off` in a Gitpod terminal.



**Specific development servers**

If you are running more than one development server at the same time or you are not running the default development server then you can toggle the debugging session for a specific server:

 `debug on apache` or `debug_on php`



**Setting breakpoints**

- Once the preview browser is open, You can set a breakpoint in the Gitpod IDE by clicking in the gutter next to the line of code you want in any `php` file in the `public` folder (or deeper) 
- Then in the Gitpod IDE in the browser:
  2. Hit the debug icon in the left side panel to open the Debug panel.
  3. Choose "Listen for XDebug" from the dropdown list.
  4. Hit the green play button (you should see the status "RUNNING" in the Threads panel)
  5. Refresh the preview browser and you should now hit your breakpoint.

All debugging is subject to server timeout, refreshing the preview browser will make this go away.



**Debugging Blade templates**


You may also debug blade templates by placing the following snippet above where you want to inspect the blade directive.

```php
<?php xdebug_break(); ?>
```

Save the file and refresh the preview browser when the debugger is in the IDE.

If all else fails stop the debugger, launch the "Listen for Xdebug" launch configuration again and refresh the preview browser.
This will open a temporary `php` file that has all the blade directives converted to `php` tags, you may set additional breakpoints in this code as well. Do not edit the code in these temporary files as it they be disposed and are only derived for that debugging session.



## Tailing the xdebug log

To tail the xdebug log

    1. Open a new terminal in gitpod
    2. Run the command: `tail -f /var/log/xdebug.log`



## Auto Generating a CHANGELOG.md

Keeping track of your changes and releases is easy now.

There is an option in `starter-ini` to install [github-changelog-generator] (https://github.com/github-changelog-generator/github-changelog-generator). 

This option is on by default, additional settings for this option can be found in `starter.ini`.

You can generate a CHANGELOG.md at any time by running the command:

`rake changelog`

See [github-changelog-generator] (https://github.com/github-changelog-generator/github-changelog-generator) for more details on what you can do with it.



## Emoji-log

[Emoji-log](https://github.com/ahmadawais/Emoji-Log) git aliases are included. You them as you like from the command line.



## Local Development Outside of Gitpod ##

For now this will be something you need to figure out. Eventually some guidelines for how to do that with vscode will be added here.

*Thanks to the gitpod community and xdebug!