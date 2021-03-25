## Introduction: Laravel 8 Gitpod Starter

🚀
Laravel 8 Gitpod Starter is a [Laravel 8](https://laravel.com/docs/8.x/) 'starter project' designed to be developed in the cloud on the [Gitpod](https://www.gitpod.io/) platform. The core of this project is a simple configuration file and a series of bash scripts that set up a [LAMP](https://en.wikipedia.org/wiki/LAMP_(software_bundle)) stack in the cloud with options to install and auto-configure various popular libraries, authorization, and front-end project scaffolding such as React, Vue, and Bootstrap.
Just [copy this repository](#tldr-quick-setup---create-a-new-project-repository-from-this-repository) into a new project repository of your own, edit the `starter.ini` file to your liking and you are ready to develop your project in the cloud.

[![Try it out on on Gitpod.io](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://github.com/apolopena/gitpod-laravel8-starter) with [![emoji-log](https://cdn.rawgit.com/ahmadawais/stuff/ca97874/emoji-log/flat-round.svg)](https://github.com/ahmadawais/Emoji-Log/) built into the environment.


<br />

# Table of Contents

1. [Introduction: Laravel 8 Gitpod Starter](#introduction-laravel-8-gitpod-starter)
2. [Requirements](#Requirements)
3. [Setting Up](#Setting-Up)
   - 3.1 [Tl;dr Quick Setup](#tldr-quick-setup---create-a-new-project-repository-from-this-repository)
   - 3.2 [Breakdown of the Steps to Create a new Project Repository](#breakdown-of-the-steps-for-creating-a-new-project-from-this-repository)
   - 3.4 [Creating a new workspace in Gitpod from your new GitHub project repository](#creating-a-new-workspace-in-gitpod-from-your-new-github-project-repository)
4. [Running the Client](#running-the-client)
5. [Pushing the Scaffolding Files to Your Remote Repository](#pushing-the-scaffolding-files-to-your-remote-repository)
   - 5.1 [Gitpod account permissions](#gitpod-account-permissions)
   - 5.2 [GitHub email protection](#GitHub-email-protection)
6. [Starter Project Configuration](#Starter-Project-Configuration)
   - 6.1 [Development Servers](#development-servers)
   - 6.2 [Changing the default server](#changing-the-default-server)
   - 6.3 [Running more than one server at a time](#running-more-than-one-server-at-a-time)
7. [Debugging](#debugging)
   - 7.1 [The default development server](#the-default-development-server)
   - 7.2 [Specific development servers](#specific-development-servers)
   - 7.3 [Setting breakpoints](#setting-breakpoints)
   - 7.4 [Debugging Blade templates](#debugging-blade-templates)
   - 7.5 [Tailing the Xdebug Log](#tailing-the-xdebug-log)
8. [phpMyAdmin](#phpmyadmin)
   - 8.1 [Installing phpMyAdmin](#installing-phpmyadmin)
   - 8.2 [Security Concerns](#security-concerns)
   - 8.3 [Securing phpMyAdmin](#securing-phpmyadmin)
9. [Generating a CHANGELOG.md Using github-changelog-generator](#generating-a-changelogmd-using-github-changelog-generator)
   - 9.1 [Setting up an Access Token for github-changelog-generator](#setting-up-an-access-token-for-github-changelog-generator)
10. [Project Specific Bash Code for Gitpod](#project-specific-bash-code-for-gitpod)
11. [Ruby Gems](#ruby-gems)
12. [Emoji-log and Gitmoji](#emoji-log-and-gitmoji)
13. [Local Development Outside of Gitpod](#local-development-outside-of-gitpod)
14. [Deployment Outside of Gitpod](#deployment-outside-of-gitpod)
15. [Gitpod Caveats](#gitpod-caveats)
16. [Thanks](#thanks)

<br />

## Requirements

- A [GitHub](https://github.com/) account (a free account is fine)

- A [GitPod](https://www.gitpod.io/) account (a free account is fine)

<br />

## Setting Up

Gitpod will use the name of your GitHub repository as the Laravel project name so make sure you name your project repository accordingly. There are many ways to copy a repository but when using this starter proejct it is advised that you copy it, delete the git history and give it a new name. 

You may also just fork this repository if you simply want to dabble with the starter project but do no intend to make it a standalone project with it's own name. 

### Tl;dr Quick Setup - Create a new project repository from this repository

1. Make a new repository from your GitHub account.
2. On your local machine copy and paste the below one-liner command into your terminal.
   - Make sure you replace the `PLACEHOLDER` values with your GitHub user name and new GitHub repository name

```bash
__new_repo_project_name=PLACEHOLDER; __github_username=PLACEHOLDER; mkdir "$__new_repo_project_name" && cd "$__new_repo_project_name" && git clone https://github.com/apolopena/gitpod-laravel8-starter.git . && rm -rf .git && git init && git add -A && git commit -m "initial commit built from https://github.com/apolopena/gitpod-laravel8-starter" && git remote add origin "https://github.com/$__github_username/$__new_repo_project_name.git" && git branch -m main && git push -u origin main
```

**Note**: You may also create a new project from a *branch* of this repository by using the below one-liner. Make sure you replace the `PLACEHOLDER` values with your branch name, new GitHub repository name and GitHub user name respectively. The branch name must be a valid remote branch.

```bash
__branch=PLACEHOLDER; __new_repo_project_name=PLACEHOLDER; __github_username=PLACEHOLDER; mkdir "$__new_repo_project_name" && cd "$__new_repo_project_name" && git clone https://github.com/apolopena/gitpod-laravel8-starter.git -b "$__branch" --single-branch . && rm -rf .git && git init && git add -A && git commit -m "initial commit built from the $__branch branch of  https://github.com/apolopena/gitpod-laravel8-starter" && git remote add origin "https://github.com/$__github_username/$__new_repo_project_name.git" && git branch -m main && git push -u origin main
```

 You can now skip to the section of how to [initialize your Gitpod workspace](#creating-a-new-workspace-in-gitpod-from-your-new-github-project-repositor) if you like or just read on.

### Breakdown of the steps for creating a new project from this repository

*Copy this GitHub repository into a new GitHub repository of your own and of course be sure to name that repository with the name of your project. These instructions assume you have a bash or bash like shell to work with but if you don't you will have to figure out the equivalent commands on your own.*

 1. In a web browser, [make a new repository in GitHub](https://docs.github.com/en/github/getting-started-with-github/create-a-repo).

 2. On your local machine create a directory that has the *same name* as your newly created repository in the previous step. For the sake of instruction lets say you named the repo NEW_PROJECT_REPO_NAME.

    - > run `mkdir NEW_PROJECT_REPO_NAME`

 3. Move into your newly created local folder.

    - > run `cd NEW_PROJECT_REPO_NAME`

 4. Clone this repository into your newly created local folder. Pay close attention to the `.` at the end of this command as you do not want and extra folder named gitpod-laravel8-starter in your project repo. You may use the SSH URL if you like. This example uses the HTTPS URL.

    - > run `git clone https://github.com/apolopena/gitpod-laravel8-starter.git .`

 5. Delete all the git history (important step).

    - > run `rm -rf .git`

 6. Initialize the local git repository.

    - > run `git init`

 7. Add all the files to the local git repository.

    - > run `git add -A`

 8. Commit all the files to the local git repository.

    - > run `git commit -m "initial commit built from https://github.com/apolopena/gitpod-laravel8-starter"`

 9. Add the URL for the remote repository where your local repository will be pushed to. You can use SSH or HTTPS as mentioned in step 4. If you don't know how to find the remote URL for your repository you read [this](https://checkmarx.atlassian.net/wiki/spaces/KC/pages/131432811/GitHub+-+Tips+on+Finding+Git+GitHub+Repository+URLs#:~:text=Tip%20to%20find%20the%20Github,link%20as%20a%20regular%20URL.).

    - The command will look something like this:
      - `git remote add origin https://github.com/<github user name>/NEW_PROJECT_REPO_NAME.git`
      - Make sure you swap out \<github user name> with your GitHub user name. 

 10. Create the local main branch. Note: main branches are now called `main` and are no longer called `master`.

     - > run `git branch -m main`

 11. Finally push your local repository main branch to the remote upstream on the GitHub servers.

    - > run `git push -u origin main`

### Creating a new workspace in Gitpod from your new GitHub project repository

Create a Gitpod workspace for the first time. Gitpod makes this easy. One simple URL deploys the entire system.

   - Paste URL your newly created GitHub repository to the end of the special Gitpod URL, **https://gitpod.io/#/**.
      - For example if your repository URL is **https://github.com/myusername/myprojectname** then the Gitpod workspace build URL needs to look like this: 
      - **https://gitpod.io/#/https://github.com/myusername/myprojectname**
      - Note: Gitpod also supports creating a workspace from a branch by using the branch URL.


Initialize the Gitpod workspace by pasting the Gitpod URL you created in the previous step into your browser.

Initializing the workspace for the first time can take up to 5 or 6 minutes. Subsequent starts of the workspace should be much quicker due to caching mechanisms.

   - When the workspace is created for the first time an entire online development environment complete with an IDE is deployed along with an addtional installations you have set in `starter.ini`. Scaffolding files for the Laravel 8 project and debugging capabilities are also created the first time you build the workspace so it will be up to you to push those newly created files to your repository before you get started developing your project.

<br />

## Running the Client

A preview browser should automatically open and display the Laravel start page. This page is being served by the default web server which is set in `starter.ini`. The code for this page is in `/resources/views/welcome.blade.php` In the IDE there is a UI for hiding the preview browser panel and for launching the preview browser in a separate window. Look on the right side area of the IDE for these controls.

Note: Gitpod is constantly being improved such as being able to choose the IDE container you want to use. Because of this instructions may vary from IDE to IDE. Currently the preview browser is not available with the VSCode IDE.

<br />

## Pushing the Scaffolding Files to Your Remote Repository

If the results log shows success, you should push the newly created project files to your remote repository. 

*If you do not push the newly created project files to your remote repository they will be recreated every time you create a new Gitpod workspace until you do so.*

### Gitpod account permissions

You may need to allow Gitpod additional permissions to push to your repository so if you come across an issue like [this one](https://community.gitpod.io/t/i-cant-push-my-changes-to-my-github-remote-repository/629), that is what you will need to do.

### GitHub email protection

If your GitHub account uses the protected email feature and the email address you are using in your git configuration looks something like this:

`3366792+myusername@users.noreply.github.com`

you may encounter an error that looks something like this:

`! [remote rejected] readme-dev -> readme-dev (push declined due to email privacy restrictions)`

The easiest way to get past this error is to uncheck the box labeled "**Block command line pushes that expose my email**" under Settings-->Emails in your GitHub account.

If you don't want to do this then you can edit the `~/.gitconfig` file in your Gitpod workspace to use your protected email address since Gitpod defaults to using the unprotected email address for your GitHub account. Please note that if you do this you will have to make this change for _every_ workspace you create.

<br />

## Starter Project Configuration

This starter project tries to be as less opinionated as possible. A configuration file has been provided to allow you to control many aspects of the development environment and the Laravel project scaffolding. 

The file `starter.ini` in the root of the project allows you to configure optional installations and other various configurations. See the comments in `starter.ini` for what you can do with it. Simply change values in `starter.ini`, push those changes to your repository, create a new Gitpod workspace from that repo and your new configurations will be enabled.

There is an exception regarding the installation of `phpmyadmin`. This optional installation works however it is prone to be cached by Docker. Please see this [issue](https://github.com/apolopena/gitpod-laravel8-starter/issues/28) for more details.

In general it is best to set values in `starter.ini` just once before you create your workspace for the first time.

### Development Servers

This starter project comes pre packaged with two development servers.

- Apache2
- PHP Development Sever

By default the server listed in `starter.ini` will be the server used. You can however run both servers at the same time or change your default server.

You may also run the PHP Development server manually via the command `php artisan serve`.

The default server will be started automatically when the workspace is started.

You can toggle any server on and off from any terminal window by running the relevant command. These commands will also dynamically kill the log monitor process for that server:

- Apache: `start_apache` or `stop_apache`

- PHP  built-in development server: `start_php_dev` or `stop_php_dev`

### Changing the default server

Change the value of  `default_server` in the `development` section of `starter.ini` to either `php` or `apache`

### Changing the apache log monitor binary

The system will show apache logs with either `multitail` or a colorized tail (using `grc`).

Change the value of `apache_log_monitor` in the `development` section of `starter.ini` to either `tail` or `multitail`

Note: `multitail` is prone to [issues](https://github.com/apolopena/gitpod-laravel8-starter/issues/53) depending on the size of the terminal it is launched in so the default is a colorized `tail`.

### Running more than one server at a time

You may start and stop multiple servers.

If you have the Apache server running and you want to run the PHP development server at the same time just run this command:

`start_server php`

Now the PHP server will be running in parallel.

Note: Laravel requires a url to be set in the `.env` file in the project root. This is done for you automatically when the workspace is initialized. The url set in the `.env` file contains the server port so if you want to properly serve Laravel pages from a server other than the default server you initialized the project with then will need to change the values for APP_URL and ASSET_URL accordingly.

<br />

## Debugging

Debugging must be enabled before breakpoints can be hit and will last for an hour before the debug session is disabled automatically.

When debugging is enabled or disabled, the preview browser will reload the index page. When debugging is enabled, *each* subsequent request can be debugged for an hour or until debugging is disabled.

This system uses port `9009` for the debugging. A launch configuration file is included in `.theia/launch.json`.

### The default development server

To enable a debugging session on the default development server run `debug-on` in a Gitpod terminal. 
To disable a debugging session on the default development server run `debug-off` in a Gitpod terminal.

### Specific development servers

If you are running more than one development server at the same time or you are not running the default development server then you can toggle the debugging session for a specific server:

 `debug-on apache` or `debug-on php`

### Setting breakpoints

- Once the preview browser is open, You can set a breakpoint in the Gitpod IDE by clicking in the gutter next to the line of code you want in any PHP file in the `public` folder (or deeper) 
- Then in the Gitpod IDE in the browser:
  1. Hit the debug icon in the left side panel to open the Debug panel.
  2. Choose "Listen for XDebug" from the dropdown list.
  3. Hit the green play button (you should see the status "RUNNING" in the Threads panel)
  4. Refresh the preview browser and you should now hit your breakpoint in the IDE.

All debugging is subject to server timeout, just refreshing preview browser if this happens.

### Debugging Blade templates

You may also debug blade templates by placing the following snippet above where you want to inspect the blade directive.

```php
<?php xdebug_break(); ?>
```

Save the file and refresh the preview browser when the debugger is in the IDE.

This will open a temporary PHP file that has all the blade directives converted to `php` tags, you may set additional breakpoints in this code as well. Do not edit the code in these temporary files as it they be disposed at any time and are only derived for that debugging session.

If you are having trouble, launch the "Listen for Xdebug" launch configuration again and refresh the preview browser.

<br />

## Tailing the Xdebug Log

   1. Open a new terminal in gitpod
   2. Run the command: `tail -f /var/log/xdebug.log`

<br />

## phpMyAdmin ##

phpMyAdmin is a tool that handles MySQL administration over the web. This tool is very powerful and can be essential when developing MySQL powered systems especially in the cloud. For more information on what phpMyAdmin can do, check out the [official documentation](https://www.phpmyadmin.net/docs/), the [user guide](https://docs.phpmyadmin.net/en/latest/user.html) or just dabble around on the [demo server](https://www.phpmyadmin.net/try/).

### Installing phpMyAdmin
phpMyAdmin is installed automatically by default. A phpMyAdmin installation directive is available in `starter.ini` that allows you to omit the installation if you like.

### Security Concerns

phpMyAdmin also introduces some extra security concerns that should be addressed. If you have installed phpMyAdmin using install directive starter.ini then by default two MySQL accounts are created using default passwords stored in version control:

   - **pmasu**: This is the superuser account that a developer can use to log into phpMyAdmin in order to administer any MySQL database.
     - The default password for the user **pmasu** is: ***123456***
- **pma**: This is the controluser that the phpMyAdmin uses internally to manage it's advanced storage features which are enabled by default. This user can only administer the `phpmyadmin` database and should not be used by anyone.
  - The default password the user **pma** is: ***pmapass***

<br />

### Securing phpMyAdmin

At a minimum the default passwords that phpMyAdmin uses to administer the MySQL databases should be changed right after a Gitpod workspace has been created for the first time. An `update_phpmyadmin_pws` alias has been provided that automagically changes the default passwords.
<br /><br />
To change the phpMyAdmin  MySQL passwords using the `update_phpmyadmin_pws` alias, follow these steps:
   1. Create a file in the root of the project named `.starter.env`
   2. Copy and paste all the keys containing `PHPMYADMIN` from `.starter.env.example` to `.starter.env`
   3. In .starter.ini, set password values for the `PHPMYADMIN` keys and save the file.
   4. In a terminal run the alias: `update_phpmyadmin_pws`

<br />

## Generating a CHANGELOG.md Using github-changelog-generator

Keeping track of your changes and releases can easily be automated.
There is an option in `starter-ini` to install [`github-changelog-generator`](https://github.com/github-changelog-generator/github-changelog-generator). 
This option is on by default, additional settings for this option can be found in `starter.ini`.
You can generate a `CHANGELOG.md` by running the command:
`rake changelog`
Currently generating a changelog can only be done when the workspace is built for the first time. See [here](https://github.com/apolopena/gitpod-laravel8-starter/issues/57) for more details
See [github-changelog-generator](https://github.com/github-changelog-generator/github-changelog-generator) for more information on what you can do with it.
Note: any options you may need to pass in can be passed in through the rake command: `rake changelog`.

### Setting up an Access Token for github-changelog-generator

GitHub limits API calls unless using an [access token](https://github.com/settings/tokens/).
`github-changelog-generator` uses the GitHub API to generate a `CHANGELOG.md` and will quickly max out of API calls if you try to generate the `CHANGELOG.md` more than a few times in a certain period of time.
It is recommended that you setup an access token from your GitHub account and then set that access token in an environment variable via your Gitpod dashboard. This way any project you like can generate a `CHANGELOG.md` as many times as it likes without error.

1. You can generate an access token [here](https://github.com/settings/tokens/new?description=GitHub%20Changelog%20Generator%20token). If the repository is public you do not need to grant any special privileges, just generate the token and copy it to your clipboard. Otherwise if the repository is private you need to grant it 'repo' privileges.
2. Once you have the github access token copied to your clipboard, in your gitpod account go to settings in the Environment Variables section click the "Add Variable" button.
3. For the 'name' field value type in `CHANGELOG_GITHUB_TOKEN`
4. For the 'value' field paste in your github access token
5. For the 'Organization/Repository' field you may leave it as it or type in GITHUBUSERNAME/* where GITHUBUSERNAME is the user name of your github account. This will allow you to use the github-changelog-generator as many times as you like for any of your repositories. 
6. Restart or create a new workspace and you will now be able to use `github-changelog-generator` via the `rake changelog` command as many times as you like.

Important Note: If you do not generate an access token for `github-changelog-generator` and if you do not cancel the error that results when you exceed your Github API calls when using it you could potentially run out of space for your github workspaces and not be able to create any any new workspace or open any existing ones until you delete the offending workspace(s).

<br />

## Project Specific Bash Code for Gitpod

Bash code that should be run when your Gitpod workspace is created for the first time should be put in the file: 
`bash/init-project.sh`
This file contains some basic scaffolding and examples that you can use in your project if you like.

<br />

## Ruby Gems

Currently until gitpod fixes the [issue](https://github.com/apolopena/gitpod-laravel8-starter/issues/57) of ruby gems not persisting across workspace restarts, you can only use rake commands when the workspace is created for the first time.

<br />

## Emoji-log and Gitmoji

A compilation of git aliases from [Emoji-log](https://github.com/ahmadawais/Emoji-Log) and [Gitmoji](https://gitmoji.dev/) are included, use them as you like from the command line. There is also a separate set of emoji based git aliases that will commit the files with a message and push them to the repository *without* adding the files. Use these aliases for dealing with groups of files that need different commit messages but still need to use to Emoji-log and or Gitmoji standards. You can get a list of all the emoji based git alias with the command: `git a`

<br />

## Local Development Outside of Gitpod ##

For now this will be something you need to figure out. Eventually some guidelines for how to do that will be added here.

<br />

## Deployment Outside of Gitpod

For now this will be something you need to figure out. Eventually some guidelines for how to do that will be added here.

<br />

## Gitpod Caveats
Gitpod is an amazing and dynamic platform however at times, and especially during it's peak hours latency can affect the workspace. Here are a few symptoms that you can try to remedy by recreating the workspace or waiting for some time before trying to open or create a workspace. This section will be updated as Gitpod progresses.
  - **Symptom**: Workspace loads, IDE displays, however one or more terminals are blank.
    - **Possible Fix**: Delete the workspace in your Gitpod dashboard and then [recreate the workspace](#creating-a-new-workspace-in-gitpod-from-your-new-github-project-repository).
  - **Symptom**: Workspace loads, IDE displays, however no ports become available and or the spinner stays spinning in the terminal even after a couple of minutes.
    - **Possible Fix**: Refresh the browser


## Thanks

To the communities of:

- Gitpod
- Laravel
- Xdebug