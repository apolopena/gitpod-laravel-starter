# Welcome

🚀
`gitpod-laravel-starter` is a starting point for [developing in the cloud](https://www.gitpod.io/) with [Laravel](https://laravel.com/) web application framework and [MySql](https://www.mysql.com/products/community/).
* Supports Laravel 6, 7, and 8
* Develop in the cloud on the [Gitpod](https://www.gitpod.io/) platform
* Preconfigured yet fully customizable [LAMP](https://en.wikipedia.org/wiki/LAMP_(software_bundle)) or [LEMP](https://lemp.io/) stack
* Full debugging capabilities
* Preset frontends for [React](https://reactjs.org/), [Vue](https://vuejs.org/), and [Bootstrap](https://getbootstrap.com/).
* Auth scaffolding can be included with any preset frontend

If you want to jump right in to [setting up a project](https://github.com/apolopena/gitpod-laravel-starter/wiki/Setup) or maybe you just like **tdlr;** sections then have a look at the wiki [setup page](https://github.com/apolopena/gitpod-laravel-starter/wiki/Setup).

`gitpod-laravel-starter` is designed for any type of developer from beginners to professionals to hobbyists. Developing in the cloud has many benefits including giving developers the freedom to try entire complex technological stacks with a single click.

## _Powered 100% by open source_:
<a href="https://www.gitpod.io/"><img src="https://gitpod.io/static/media/gitpod.2cdd910d.svg" alt="Gitpod - Spin up fresh, automated dev environments
for each task, in the cloud, in seconds" width="70" ></a>**Gitpod**
 <a href="https://laravel.com/"><img src="https://upload.wikimedia.org/wikipedia/commons/9/9a/Laravel.svg" alt="Laravel - The PHP Framework for Web Artisans" width="65" ><img src="https://laravel.com/img/logotype.min.svg" width="100"></a>
 <a href="https://www.php.net/"><img src="https://www.php.net/images/logos/new-php-logo.svg" alt="PHP - A popular general-purpose scripting language that is especially suited to web development" width="130" ></a>

<a href="https://www.mysql.com/products/community/"><img src="https://www.logo.wine/a/logo/MySQL/MySQL-Logo.wine.svg" alt="MySQL Community Edition - Freely downloadable version of the world's most popular open source database" width="140" ></a>
 <a href="https://httpd.apache.org/"><img src="https://upload.wikimedia.org/wikipedia/commons/1/10/Apache_HTTP_server_logo_%282019-present%29.svg" alt="The Apache Software Foundation, Apache License 2.0 <http://www.apache.org/licenses/LICENSE-2.0>, via Wikimedia Commons" width="165" ></a>
 <a href="hhttps://www.nginx.com/resources/wiki/"><img src="https://upload.wikimedia.org/wikipedia/commons/c/c5/Nginx_logo.svg" alt="NGINX - A free, open-source, high-performance HTTP server and reverse proxy, as well as an IMAP/POP3 proxy server." width="150" ></a>

<a href="https://www.gnu.org/software/bash/"><img src="https://upload.wikimedia.org/wikipedia/commons/4/4b/Bash_Logo_Colored.svg" alt="Bootstrap - Build fast, responsive sites with Bootstrap" width="80" ></a>
  <a href="https://reactjs.org/"><img src="https://upload.wikimedia.org/wikipedia/commons/a/a7/React-icon.svg" alt="Bash  A Unix shell and command language written by Brian Fox for the GNU Project" width="115" ></a>
<a href="https://vuejs.org/"><img src="https://upload.wikimedia.org/wikipedia/commons/9/95/Vue.js_Logo_2.svg" alt="Vue.js - The Progressive
JavaScript Framework" width="72" ></a>
  <a href="https://getbootstrap.com/"><img src="https://cdn.worldvectorlogo.com/logos/bootstrap-5-1.svg" alt="Bootstrap - Build fast, responsive sites with Bootstrap" width="82" ></a>


<br />

# Table of Contents

1. [Welcome](#Welcome)
2. [Requirements](#Requirements)
3. [Setting Up a Repository](#setting-up-a-repository)
   - 3.1 [Creating a new Gitpod Workspace from a GitHub repository](#creating-a-new-gitpod-workspace-from-a-github-repository)
4. [Running the Client](#running-the-client)
5. [Pushing Laravel scaffolding Files to Your Remote Repository](#pushing-laravel-scaffolding-files-to-your-remote-repository)
   - 5.1 [Gitpod account permissions](#gitpod-account-permissions)
   - 5.2 [GitHub email protection](#GitHub-email-protection)
6. [Starter Project Configuration](#Starter-Project-Configuration)
   - 6.1 [Preset Examples](#preset-examples)
   - 6.2 [Development Servers](#development-servers)
   - 6.3 [Changing the default server](#changing-the-default-server)
   - 6.4 [Running more than one server at a time](#running-more-than-one-server-at-a-time)
   - 6.5 [Changing the Laravel Version](#changing-the-laravel-version)
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
13. [Deployment Outside of Gitpod](#deployment-outside-of-gitpod)
14. [Gitpod Caveats](#gitpod-caveats)
15. [Thanks](#thanks)

<br />

## Requirements

- A [GitHub](https://github.com/) account (a free account is fine)

- A [GitPod](https://www.gitpod.io/) account (a free account is fine)

<br />

## Setting Up a Repository
There are many ways to use `gitpod-laravel-starter`.

Setup instructions can be found on the wiki [setup page](https://github.com/apolopena/gitpod-laravel-starter/wiki/Setup)

### Creating a new Gitpod Workspace from a Github repository

Gitpod makes this easy. One simple URL deploys the entire system.

   - Paste you GitHub repository URL to the end of the special Gitpod URL: **https://gitpod.io/#/**.
   - If you don't need to push changes and you just want to try this repository with the default configuration you can click here [![Try it out on on Gitpod.io](https://gitpod.io/button/open-in-gitpod.svg)](http://gitpod.io/#/https://github.com/apolopena/gitpod-laravel-starter)
   - Instructions for setting up a repository of your own can be found on the [wiki setup page](https://github.com/apolopena/gitpod-laravel-starter/wiki/Setup)

Initializing the workspace for the first time can take up to 5 minutes depending on how you have [configured](#starter-project-configuration) `starter.ini`. Subsequent starts or creation of the workspace will be much quicker due to caching mechanisms.

When the workspace is created for the first time an entire online development environment complete with an IDE is deployed along with any additional installations you have set in `starter.ini`. Laravel scaffolding files and debugging capabilities are created the first time you build the workspace so you should push any new files to your repository before you get started developing your project. You can push the files with a single command: `git new "Initial Commit"`

<br />

## Running the Client

Once the system is ready. A preview browser should automatically open and display the Laravel start page. This page is being served by the default web server which is set in `starter.ini`. The code for this page is in `/resources/views/welcome.blade.php`. To manually open the preview browser or to refresh it you can run the command `op`.

<br />

## Pushing Laravel scaffolding Files to Your Remote Repository

If the results log summary in the console shows success, you should push the newly created Laravel scaffolding files to your remote repository. 

### Gitpod account permissions

You may need to allow Gitpod additional permissions to push to your repository in case you come across an issue like [this one](https://community.gitpod.io/t/i-cant-push-my-changes-to-my-github-remote-repository/629).

### GitHub email protection

If your GitHub account uses the protected email feature and the email address you are using in your git configuration looks something like this:

`3366792+myusername@users.noreply.github.com`

you may encounter an error that looks something like this:

`! [remote rejected] readme-dev -> readme-dev (push declined due to email privacy restrictions)`

The easiest way to circumvent error is to uncheck the box labeled "**Block command line pushes that expose my email**" under **Settings**-->**Emails** in your GitHub account.

Another workaround is to edit the `~/.gitconfig` file in your Gitpod workspace to use your protected email address since Gitpod defaults to using the unprotected email address for your GitHub account. Please note that if you do this you will have to make this change for **_every_** time  you create a new workspace.

<br />

## Starter Project Configuration

A configuration file has been provided to allow you to control many aspects of the development environment and the Laravel project scaffolding.

The file `starter.ini` in the root of the project allows you to configure optional installations and other various configurations. Have a look at the comments in `starter.ini` for details and acceptable values you can use. Simply change values in `starter.ini`, push those changes to your repository, create a new Gitpod workspace from that repo and your new configurations will be enabled. Some of the configurations you can change are:
-  Server: `apache`, `nginx` or `php` (development server)
-  Optional installations
    - `phpMyAdmin`
    - Frontend: `react`, `vue` or plain `bootstrap`
    - Your servers log monitor: `tail` with colorized log or `multitail`
    - .editorconfig: You can omit or use a less opinionated version of this file than what Laravel gives you by default
    - [github-change-log-generator](https://github.com/github-changelog-generator/github-changelog-generator)

### Preset Examples
`gitpod-laravel-starter` preset examples are auto-configured examples of React and Vue projects.
You can activate a preset example as a starting point by adding `EXAMPLE=<id>` to the Gitpod URL right after the `#` and followed by a `\`.
| id | Description | Sample URL |
| :---:  | :--- | :--- |
| 1 | React Example with phpMyAdmin - Questions and Answers | https://gitpod.io/#EXAMPLE=1/https://github.com/apolopena/gitpod-laravel8-starter |
| 2 | React Example without phpMyAdmin - Questions and Answers | https://gitpod.io/#EXAMPLE=2/https://github.com/apolopena/gitpod-laravel8-starter |
| 10 | Vue Example with phpMyAdmin - Material Dashboard | https://gitpod.io/#EXAMPLE=10/https://github.com/apolopena/gitpod-laravel8-starter |
| 11 | Vue Example without phpMyAdmin - Material Dashboard | https://gitpod.io/#EXAMPLE=11/https://github.com/apolopena/gitpod-laravel8-starter |

### Development Servers

This starter project comes pre-packaged with three development servers which serve on the following ports.

- Apache: port 8001
- Nginx (with `php-fpm`): port 8002
- PHP Development Sever: port 8000

By default the server listed in `starter.ini` will be the server used. You can run any server at the same time or change your default server in `starter.ini` at any time. 

Keep in mind that Laravel uses the APP_URL and ASSET_URL variables set in `.env`. These values are set during workspace initialization and are based on the default server you are using. If you want serve the project using a different server _during_ a workspace session then you will need to change APP_URL and ASSET_URL in `.env` to have the port number in it for the server you want to use.

You may also run the PHP Development server manually via the command `php artisan serve`.

The default server will be started automatically when the workspace is started.

You can toggle any server on and off from any terminal window by running the relevant command. These commands will also dynamically kill the log monitor process for that server:

- Apache: `start_apache` or `stop_apache`
- Nginx `start_nginx` or `stop_nginx`
- PHP  built-in development server: `start_php_dev` or `stop_php_dev`

### Changing the default server

Change the value of  `default_server` in the `development` section of `starter.ini` to `apache`, `nginx`, or `php`

### Running more than one server at a time

You may start and stop multiple servers.

If you have the Apache server running and you want to run the Nginx server at the same time just run this command:

`start_nginx`

Now the nginx server will be running in parallel.

Laravel requires a URL to be set in the `.env` file in the project root. This is done for you automatically when the workspace is initialized. The URL set in the `.env` file contains the server port. so if you want to properly serve Laravel pages from a server other than the default server you initialized the project with then will need to change the values for APP_URL and ASSET_URL accordingly.

### Changing the Laravel Version
In `starter.ini` there is a directive to change the version of Laravel. 

**Important**:
- By default `gitpod-laravel-starter` uses the most recent version of Laravel. Currently this is version `8.*`
- There are exactly three supported values for the Laravel version directive: `8.*`, `7.*`, and `6.*` 
- Laravel will always use the most recent/stable minor and patch version for any major version

**Caveats**:
 - Upgrading or downgrading Laravel once Laravel scaffolding files have been saved to your repository is not advised and should not be done
 - Attempts to upgrade will will result in an automatic downgrade and could cause instability
 - Attempts to downgrade will be ignored and could cause instability

<br />

## Debugging

Debugging must be enabled before breakpoints can be hit and will last for an hour before the debug session is disabled automatically.

When debugging is enabled or disabled, the preview browser will reload the index page. When debugging is enabled, *each* subsequent request can be debugged for an hour or until debugging is disabled.

This system uses port `9009` for the debugging. A launch configuration file is included in `.theia/launch.json`.

### The default development server

To enable a debugging session on the default development server run `debug-on` in a Gitpod terminal. 
To disable a debugging session on the default development server run `debug-off` in a Gitpod terminal.

### Specific development servers

You can toggle the debugging session for a specific server:

- Apache
    - `debug-on apache` or `debug-off apache`
- Nginx
    - `debug-on nginx` or `debug-off nginx`
- PHP (development server)
    - `debug-on php` or `debug-off php`

### Setting breakpoints

Set a breakpoint in the Gitpod IDE by clicking in the gutter next to the line of code you want in any PHP file in the `public` folder (or deeper) 

Then in the Gitpod IDE in the browser:
1. Hit the debug icon in the left side panel to open the Debug panel.
2. Choose "Listen for XDebug" from the dropdown list.
3. Hit the green play button (you should see the status "RUNNING" in the Threads panel)
4. Refresh the preview browser either manually or with the command `op` and your breakpoint will be hit in the IDE.

All debugging is subject to server timeout, just refresh preview browser or run the command `op` if this happens.

### Debugging Blade templates

You may also debug blade templates by placing the following snippet above where you want to inspect the blade directive.

```php
<?php xdebug_break(); ?>
```

Save the file and refresh the preview browser when the debugger is in the IDE.

This will open a temporary PHP file that has all the blade directives converted to `php` tags, you may set additional breakpoints in this code as well. Do not edit the code in these temporary files as it they be disposed at any time and are only derived for the current debugging session.

If you are having trouble, launch the "Listen for Xdebug" launch configuration again and refresh the preview browser.

<br />

### Tailing the Xdebug Log

   1. Open a new terminal in gitpod
   2. Run the command: `tail -f /var/log/xdebug.log`

<br />

## phpMyAdmin ##

phpMyAdmin is a tool that handles MySQL administration over the web. This tool is very powerful and can be essential when developing MySQL powered systems especially in the cloud. For more information on what phpMyAdmin can do, check out the [official documentation](https://www.phpmyadmin.net/docs/), the [user guide](https://docs.phpmyadmin.net/en/latest/user.html) or just dabble around on the [demo server](https://www.phpmyadmin.net/try/).

### Installing phpMyAdmin
phpMyAdmin is installed automatically by default. A phpMyAdmin installation directive is available in `starter.ini` that allows you to omit the installation if you like.

### Security Concerns

phpMyAdmin also introduces some extra security concerns that you may want to address. If you have installed phpMyAdmin using the install directive in `starter.ini` then by default, two MySQL accounts are created using default passwords stored in version control:

- **pmasu**: This is the superuser account that a developer can use to log into phpMyAdmin in order to administer any MySQL database.
     - The default password for the user **pmasu** is: ***123456***
- **pma**: This is the controluser that the phpMyAdmin uses internally to manage it's advanced storage features which are enabled by default. This user can only administer the `phpmyadmin` database and should not be used by anyone.
  - The default password the user **pma** is: ***pmapass***

<br />

### Securing phpMyAdmin

At a minimum the default passwords that phpMyAdmin uses to administer the MySQL databases should be changed right after a Gitpod workspace has been created for the first time. An `update-phpmyadmin-pws` alias has been provided that automagically changes the default passwords.
<br /><br />
To change the phpMyAdmin  MySQL passwords using the `update-phpmyadmin-pws` alias, follow these steps:
   1. Create a file in .gp named `.starter.env`
   2. Copy and paste all the keys containing `PHPMYADMIN` from `.gp/.starter.env.example` to `.starter.env`
   3. In .starter.ini, set password values for the `PHPMYADMIN` keys and save the file.
   4. In a terminal run the alias: `update-phpmyadmin-pws`

<br />

## Generating a CHANGELOG.md Using github-changelog-generator

Keeping track of your changes and releases can easily be automated.
There is an option in `starter-ini` to install [`github-changelog-generator`](https://github.com/github-changelog-generator/github-changelog-generator). 
This option is on by default and additional settings for this option can be found in `starter.ini`.
You can generate a `CHANGELOG.md` by running the command:
`rake changelog`
Currently generating a changelog can only be done when the workspace is built for the first time. See [here](https://github.com/apolopena/gitpod-laravel8-starter/issues/57) for more details. See [github-changelog-generator](https://github.com/github-changelog-generator/github-changelog-generator) for documentation.

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

Important Note: If you do not generate an access token for `github-changelog-generator`, and if you do not cancel the error that results when you exceed your Github API calls when using `github-changelog-generator` then you could potentially run out of space for your github workspaces and not be able to create any any new workspace or open any existing ones until you delete the offending workspace(s) or the system is cleared automatically.

<br />

## Project Specific Bash Code for Gitpod

Bash code that you want toe run when your Gitpod workspace is created for the first time should be put in the file: 
`bash/init-project.sh`
This file contains some basic scaffolding and examples that you may use in your project.

<br />

## Ruby Gems

Currently until gitpod fixes the [issue](https://github.com/apolopena/gitpod-laravel8-starter/issues/57) of ruby gems not persisting across workspace restarts, you can only use rake commands when the workspace is created for the first time.

<br />

## Emoji-log and Gitmoji

A compilation of git aliases from [Emoji-log](https://github.com/ahmadawais/Emoji-Log) and [Gitmoji](https://gitmoji.dev/) are included, use them as you like from the command line. There is also a separate set of emoji based git aliases that will commit the files with a message and push them to the repository *without* adding the files. Use these aliases for dealing with groups of files that need different commit messages but still need to use to Emoji-log and or Gitmoji standards. You can get a list of all the emoji based git aliases with the command: `git a`

<br />

## Deployment Outside of Gitpod

For now this will be something you need to figure out. Eventually some guidelines for how to do that will be added here.

<br />

## Gitpod Caveats
Gitpod is an amazing and dynamic platform however at times, and especially during it's peak hours latency can affect the workspace. Here are a few symptoms and their possible remedies. This section will be updated as Gitpod progresses.
  - **Symptom**: Workspace loads, IDE displays, however one or more terminals are blank.
    - **Possible Fix**: Delete the workspace in your Gitpod dashboard and then [recreate the workspace](#creating-a-new-workspace-in-gitpod-from-your-new-github-project-repository).
  - **Symptom**: Workspace loads, IDE displays, however no ports become available and or the spinner stays spinning in the terminal even after a couple of minutes.
    - **Possible Fix**: Refresh the browser
    - 
You can also try to rememdy an Gitpod network hiccups by simply waiting 30 minutes and trying again.

## Thanks

To the communities of:

- Gitpod
- Laravel
- Xdebug
