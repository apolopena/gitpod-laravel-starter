# Welcome

🚀
`gitpod-laravel-starter` generates a starting point for you to [develop in the cloud](https://www.gitpod.io/) with [Laravel](https://laravel.com/) web application framework, [MySql](https://www.mysql.com/products/community/) and pretty much any other technology you would like to add.
* Supports Laravel 6, 7, and 8
* Develop in the cloud on the [Gitpod](https://www.gitpod.io/) platform
* Preconfigured yet fully customizable [LAMP](https://en.wikipedia.org/wiki/LAMP_(software_bundle)) or [LEMP](https://lemp.io/) stack
* Full debugging capabilities
* Preset frontends for [React](https://reactjs.org/), [Vue](https://vuejs.org/), and [Bootstrap](https://getbootstrap.com/).
* Auth scaffolding can be included with any preset frontend

If you want to jump right in to [setting up a project](https://github.com/apolopena/gitpod-laravel-starter/wiki/Setup) then have a look at the wiki [setup page](https://github.com/apolopena/gitpod-laravel-starter/wiki/Setup).

The [wiki](https://github.com/apolopena/gitpod-laravel-starter/wiki/Setup) is designed to provide you with essential details not found in this document such as how to easily add [hot reloading](https://github.com/apolopena/gitpod-laravel-starter/wiki/Hot-Reload) and [Typescript](https://github.com/apolopena/gitpod-laravel-starter/wiki/Typescript) to your projects. 

`gitpod-laravel-starter` is designed for any type of developer from beginner to professional to hobbyist. Developing in the cloud has many benefits including giving developers the freedom to try entire complex technological stacks with a single click.

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

1. [Welcome](#welcome)
2. [Requirements](#requirements)
3. [Setting Up a Repository](#setting-up-a-repository)
   - 3.1 [Creating a new Gitpod Workspace from a GitHub repository](#creating-a-new-gitpod-workspace-from-a-github-repository)
4. [Running the Client](#running-the-client)
5. [Pushing Laravel scaffolding Files to Your Remote Repository](#pushing-laravel-scaffolding-files-to-your-remote-repository)
   - 5.1 [Gitpod Account Permissions](#gitpod-account-permissions)
   - 5.2 [GitHub Email Protection](#github-email-protection)
6. [Starter Project Configuration](#starter-project-configuration)
   - 6.1 [Preset Examples](#preset-examples)
   - 6.2 [Development Servers](#development-servers)
   - 6.3 [Changing the Default Server](#changing-the-default-server)
   - 6.4 [Running More Than one Server at a Time](#running-more-than-one-server-at-a-time)
   - 6.5 [Changing the PHP Version and PPA](#changing-the-php-version-and-ppa)
   - 6.6 [Changing the Laravel Version](#changing-the-laravel-version)
   - 6.7 [Breaking the Docker cache](#breaking-the-docker-cache)
7. [Gitpod Environment Variables](#gitpod-environment-variables)
   - 7.1 [Sign Git commits with a GPG key](#sign-git-commits-with-a-gpg-key)
   - 7.2 [Activate an Intelliphense License Key](#activate-an-intelliphense-license-key)
8. [Additional Features](#additional-features)
   - 8.1 [Hot Reloading](#hot-reloading)
   - 8.2 [Typescript](#typescript)
9. [Debugging PHP](#debugging-php)
   - 9.1 [The Default Development Server](#the-default-development-server)
   - 9.2 [Specific Development Servers](#specific-development-servers)
   - 9.3 [Setting Breakpoints](#setting-breakpoints)
   - 9.4 [Debugging Blade Templates](#debugging-blade-templates)
   - 9.5 [Tailing the Xdebug Log](#tailing-the-xdebug-log)
10. [Debugging JavaScript](#debugging-javascript)
11. [phpMyAdmin](#phpmyadmin)
    - 11.1 [Installing phpMyAdmin](#installing-phpmyadmin)
    - 11.2 [Security Concerns](#security-concerns)
    - 11.3 [Securing phpMyAdmin](#securing-phpmyadmin)
12. [Generating a CHANGELOG.md Using github-changelog-generator](#generating-a-changelogmd-using-github-changelog-generator)
    - 12.1 [Setting up an Access Token for github-changelog-generator](#setting-up-an-access-token-for-github-changelog-generator)
13. [Project Specific Bash Code and Package Installation](#project-specific-bash-code-and-package-installation)
    - 13.1 [User Editable Files](#user-editable-files)
    - 13.2 [Migration and Seeding](#migration-and-seeding)
14. [Ruby Gems](#ruby-gems)
15. [Git Aliases](#git-aliases)
   - 15.1 [Emoji-log and Gitmoji](#emoji-log-and-gitmoji)
16. [Deployment Outside of Gitpod](#deployment-outside-of-gitpod)
17. [Gitpod Caveats](#gitpod-caveats)
18. [Thanks](#thanks)

<br />

## Requirements

- A [GitHub](https://github.com/) account. You may use a free account.

- A [GitPod](https://www.gitpod.io/) account. You may use a free account. Just log in with your github credentials.

<br />

## Setting Up a Repository
There are many ways that you can [use `gitpod-laravel-starter`](https://github.com/apolopena/gitpod-laravel-starter/wiki/Setup). __Full setup instructions can be found on the wiki [setup page](https://github.com/apolopena/gitpod-laravel-starter/wiki/Setup)__.

### Creating a new Gitpod Workspace from a Github repository

Gitpod makes this easy. One simple URL deploys the entire system.

__A detailed breakdown of the initialization phase can be found on the wiki [initialization page](https://github.com/apolopena/gitpod-laravel-starter/wiki/Initialization)__

   - Paste your GitHub repository URL to the end of the special Gitpod URL: **https://gitpod.io/#/**.
   - If you don't need to push changes and you just want to try this repository with the default configuration you can click here [![Try it out on on Gitpod.io](https://gitpod.io/button/open-in-gitpod.svg)](http://gitpod.io/#/https://github.com/apolopena/gitpod-laravel-starter)
   - Instructions for setting up a repository of your own can be found on the wiki [setup page](https://github.com/apolopena/gitpod-laravel-starter/wiki/Setup)

Initializing the workspace will take between 2 to 5 minutes depending on how you have [configured](#starter-project-configuration) the [`starter.ini`](https://github.com/apolopena/gitpod-laravel-starter/blob/main/starter.ini) file. Subsequent starts or creation of a workspace from your repository will be much faster thanks to caching mechanisms.

When the workspace is created for the first time an entire online development environment complete with an IDE is deployed along with any additional installations you have set in `starter.ini`. Laravel scaffolding files and debugging capabilities are created the first time you build the workspace so you should push any new files to your repository before you get started developing your project. You can push the files with a single command: `git new "Initial Commit"`

<br />

## Running the Client

A preview browser should automatically open and display the Laravel start page once the system is ready. This page is served by the default web server which is set in `starter.ini`. The code for the Laravel start page page is in `/resources/views/welcome.blade.php`. To manually open the preview browser or to refresh it you can run the command `op`.

<br />

## Pushing Laravel scaffolding Files to Your Remote Repository

If the result log summary in the console shows success, then you should push those newly created Laravel scaffolding files to your remote repository before you get started coding your project. 

### Gitpod Account Permissions

You may need to allow Gitpod additional permissions to push to your repository in case you come across an issue like [this one](https://community.gitpod.io/t/i-cant-push-my-changes-to-my-github-remote-repository/629).

### GitHub Email Protection

If your GitHub account uses the protected email feature and the email address you are using in your git configuration looks something like this:

`3366792+myusername@users.noreply.github.com`

you may encounter an error that looks something like this:

`! [remote rejected] readme-dev -> readme-dev (push declined due to email privacy restrictions)`

The easiest way to circumvent error is to uncheck the box labeled "**Block command line pushes that expose my email**" under **Settings**-->**Emails** in your GitHub account.

Another workaround is to edit the `~/.gitconfig` file in your Gitpod workspace to use your protected email address since Gitpod defaults to using the unprotected email address for your GitHub account. Please note that if you do this you will have to make this change for **_every_** time  you create a new workspace.

<br />

## Starter Project Configuration

A configuration file has been provided to allow you to control many aspects of the development environment and the Laravel project scaffolding.

The file [`starter.ini`](https://github.com/apolopena/gitpod-laravel-starter/blob/hot-reload/starter.ini) in the root of the project allows you to configure optional installations and other various options. Have a look at the comments in `starter.ini` for details and acceptable values you can use. Simply change values in `starter.ini`, push those changes to your repository, create a new Gitpod workspace from that repository and your new configurations will be enabled. Some of the configurations you can make are:
-  Server: `apache`, `nginx` or `php` (development server)
-  Optional installations
    - `phpMyAdmin`
    - Frontend: `react`, `vue` or plain `bootstrap`
    - Your servers log monitor: `tail` with colorized log or `multitail`
    - `.editorconfig`: You can omit this file or use a less opinionated version of this file than what Laravel gives you by default
    - [github-change-log-generator](https://github.com/github-changelog-generator/github-changelog-generator)

*Please note that many of the configurations found in `starter.ini` should be made just once __prior__ to creating your workspace for the first time. Have a look at the comments in [`starter.ini`](https://github.com/apolopena/gitpod-laravel-starter/blob/main/starter.ini) for specifics.*

### Preset Examples
`gitpod-laravel-starter` preset examples are auto-configured examples of React and Vue projects that you can learn from or use as starting points for your own projects.

You can initialize a preset example as a starting point by adding `EXAMPLE=<id>` to the Gitpod URL right after the `#` and followed by a `/`.

To use a preset example as a starting point:
1. [Setup a project repository](https://github.com/apolopena/gitpod-laravel-starter/wiki/Setup#create-a-new-project-repository-from-gitpod-laravel-starter)
2. Initialize your workspace using the workspace URL for your corresponding EXAMPLE id but substitute https://github.com/apolopena/gitpod-laravel-starter with your project repository URL.
3. Save the system generated project scaffolding files to your new repository and you can start your project from that point.
    - Please that some directives in `starter.ini` such as `phpmyadmin` will not be supercded on subsequent initializations of your workspace. Edit your `starter.ini` as needed.

| id | Description | Workspace URL |
| :---:  | :--- | :--- |
| 1 | React Example with phpMyAdmin - Questions and Answers | https://gitpod.io/#EXAMPLE=1/https://github.com/apolopena/gitpod-laravel-starter |
| 2 | React Example without phpMyAdmin - Questions and Answers | https://gitpod.io/#EXAMPLE=2/https://github.com/apolopena/gitpod-laravel-starter |
| 3 __*__ | React Typescript Example with phpMyAdmin - Questions and Answers | https://gitpod.io/#EXAMPLE=3/https://github.com/apolopena/gitpod-laravel-starter |
| 4 __*__ | React Typescript Example without phpMyAdmin - Questions and Answers | https://gitpod.io/#EXAMPLE=4/https://github.com/apolopena/gitpod-laravel-starter |
| 10 __**__ | Vue Example with phpMyAdmin - Material Dashboard | https://gitpod.io/#EXAMPLE=10/https://github.com/apolopena/gitpod-laravel-starter |
| 11 __**__ | Vue Example without phpMyAdmin - Material Dashboard | https://gitpod.io/#EXAMPLE=11/https://github.com/apolopena/gitpod-laravel-starter |

<br />__\*__ Comes with hot reload functionality
<br />__\**__ Not designed to run in an iframe such as the preview browser in the IDE.

### Development Servers

`gitpod-laravel-starter` project comes pre-packaged with three development servers that serve on the following ports:

- Apache: port 8001
- Nginx (with `php-fpm`): port 8002
- PHP Development Sever: port 8000

By default the server set in `starter.ini` will be the server used. You can run any server at the same time or change your default server in `starter.ini` at any time. 

Please note that Laravel uses the APP_URL and ASSET_URL variables set in `.env` to serve content. These values are set during workspace initialization and are based on the default server you are using. If you want serve the project using a different server _after_ a workspace has been created, then you will need to change APP_URL and ASSET_URL in `.env` to have the port number in it for the server you want to use.

You may also run the PHP Development server manually via the command `php artisan serve` which will use port 8000.

The default server will be started automatically when the workspace is started.

You can toggle any server on and off from any terminal window by running the relevant command. These commands will also dynamically kill the log monitor process for that server:

- Apache: `start_apache` or `stop_apache`
- Nginx `start_nginx` or `stop_nginx`
- PHP  built-in development server: `start_php_dev` or `stop_php_dev`

### Changing the Default Server

Change the value of  `default_server` in the `development` section of `starter.ini` to `apache`, `nginx`, or `php`. You will need to change the APP_URL and ASSET_URL in the `.env` file to use the port number for that server if you change the default development server *after* a workspace has been created.

### Running More Than one Server at a Time

You may start and stop multiple servers.

If you have the Apache server running and you want to run the Nginx server at the same time just run this command:

`start_nginx`

The Nginx server will now be running in addition to the Apache server.

Laravel requires a URL to be set in the `.env` file in the project root. This is done for you automatically when the workspace is initialized. The URL set in the `.env` file contains the server port. so if you want to properly serve Laravel pages from a server other than the default server you initialized the project with then will need to change the values for APP_URL and ASSET_URL accordingly.


### __Changing the PHP version and PPA__
In `starter.ini` there is a `[PHP]` section and directives to change the version of PHP and or the `ppa` used for downloading the PHP packages.

<br />

Note: _See [`starter.ini`](https://github.com/apolopena/gitpod-laravel-starter/blob/main/starter.ini) for more details._

**The following values are supported in the `[PHP]` section of `starter.ini`:**
- `version`
  - `7.4`
    - The default value
    - Installs PHP 7.4. See [php.sh](https://github.com/apolopena/gitpod-laravel-starter/blob/main/.gp/bash/php.sh) for specifics.
    - The current version of PHP that gitpod installs by default in their [`workspace-full`](https://github.com/gitpod-io/workspace-images/blob/master/full/Dockerfile) image will be automatically purged.
  - `gitpodlatest`
    - This keeps the current version that gitpod installs by default in their [`workspace-full`](https://github.com/gitpod-io/workspace-images/blob/master/full/Dockerfile) image.
- `ppa`
  - `OS`
    - The default value
    - Uses the standard Debian distribution ppa
  - `ondrej`
    - Uses `ppa:ondrej/php`. This [ppa](https://launchpad.net/~ondrej/+archive/ubuntu/php) is maintained by an individual but does support the of running multiple versions of PHP side by side.

### __Changing the Laravel Version__
In `starter.ini` there is a directive to change the version of Laravel. You should only change the version of Larvel *before* you create a new workspace. The laravel version directive is cached in the workspace image so changing it sometimes requires you to [break the Docker cache](#breaking-the-docker-cache)

**Important**:
- By default `gitpod-laravel-starter` uses the most recent version of Laravel. Currently the most recent version of Laravel is `8.*`
- There are exactly three supported values for the Laravel version directive: `8.*`, `7.*`, and `6.*` 
- Laravel will always use the most recent/stable minor and patch version for any major version.

**Caveats**:
 - __Upgrading or downgrading Laravel once Laravel scaffolding files have been saved to your repository is not advised and should be avoided.__
 - Attempts to upgrade will will result in an automatic downgrade and could cause instability.
 - Attempts to downgrade will be ignored and could cause instability.
 - The Laravel version directive is cached in the workspace image so changing it requires you to break the Docker cache.

 ### Breaking the Docker cache
 You can break the Docker cache and force the workspace image to be rebuilt by incrementing the `INVALIDATE_CACHE` variable in `.gitpod.Dockerfile`. Push the changed `.gitpod.Dockerfile` to your repository, create a new gitpod workspace and the workspace image will be rebuilt. Any cached external files that Docker uses such as `starter.ini` will be updated.

<br />


## Gitpod Environment Variables
The following features can be enabled through environment variables that have been set in your [Gitpod preferences](https://gitpod.io/variables).:
<br />
\* _Please note that storing sensitive data in environment variables is not ultimately secure but should be OK for most development situations._
- ### Sign Git commits with a GPG key
   - `GPG_KEY_ID` (required)
     - The ID of the GPG key you want to use to sign your git commits
   - `GPG_KEY` (required)
     - Base64 encoded private GPG key that corresponds to your `GPG_KEY_ID`
   - `GPG_MATCH_GIT_TO_EMAIL` (optional)
     - Sets your git user.email in `~/.gitconfig` to the value provided
   - `GPG_AUTO_ULTIMATE_TRUST` (optional)
     - If the value is set to `yes` or `YES` then your `GPG_KEY` will be automatically ultimately trusted
- ### Activate an Intelliphense License Key
  - `INTELEPHENSE_LICENSEKEY`
    - Creates `~/intelephense/licence.txt` and will contain the value provided
    - This will activate [Intelliphense](https://intelephense.com/) for you each time the workspace is created or restarted

<br />

## Additional Features
To keep the `gitpod-laravel-framework` as flexible as possible, some features have been left out of the `starter.ini` configuration file. These additional features can be easily added to your project using a one-time set up process.  Wiki pages are available for each additional feature below that you may want to add to your project. Some of these features are automatically enabled for certain [preset examples](#preset-examples).

### Hot Reloading
  - `gitpod-laravel-starter` makes it easy for you to add the ability to see your code changes in realtime without refreshing the browser. Take a look at the wiki [hot reload](https://github.com/apolopena/gitpod-laravel-starter/wiki/Hot-Reload) page for more details.

### Typescript
  - Adding [Typescript](https://www.typescriptlang.org/) to your project is simple. Have a look at the wiki [Typescript page](https://github.com/apolopena/gitpod-laravel-starter/wiki/Typescript) for an example.

<br />

## Debugging PHP

Debugging must be enabled before breakpoints can be hit and will last for an hour before the debug session is disabled automatically.

When debugging is enabled or disabled, the preview browser will reload the index page. When debugging is enabled, *each* subsequent request can be debugged for an hour or until debugging is disabled.

This system uses port `9009` for the debugging. A launch configuration file is included in `.vscode/launch.json` and in `.theia/launch.json`.

### The Default Development Server

To enable a debugging session on the default development server run `debug_on` in a Gitpod terminal. 
To disable a debugging session on the default development server run `debug_off` in a Gitpod terminal.

### Specific Development Servers

You can toggle a debugging session for a specific server:

- Apache
    - `debug_on apache` or `debug_off apache`
- Nginx
    - `debug_on nginx` or `debug_off nginx`
- PHP (development server)
    - `debug_on php` or `debug_off php`

*The [hot reload](https://github.com/apolopena/gitpod-laravel-starter/wiki/Hot-Reload) webpack server on port 3005 is not supported by this debugging system. You may be able to [configure it on your own](https://stackoverflow.com/questions/28470601/how-to-do-remote-debugging-with-browser-sync) if you like.*

### Setting Breakpoints

Set a breakpoint in the Gitpod IDE by clicking in the gutter next to the line of code you want in any PHP file in the `public` folder (or deeper) 

Then in the Gitpod IDE in the browser:
1. Click the debug icon in the left side panel to open the Debug panel.
2. Choose "Listen for XDebug" from the dropdown list.
3. Click the green play button (you should see the status "RUNNING" in the CALL STACK panel)
4. Refresh the preview browser either manually or by running the `op` command and your breakpoint will be hit in the IDE.

All debugging is subject to a server timeout, just refresh preview browser or run the command `op` if this happens.

### Debugging Blade Templates

You may also debug blade templates by placing the following snippet above where you want to inspect the blade directive.

```php
<?php xdebug_break(); ?>
```

Save the file and refresh the preview browser when the debugger is in the IDE.

This will open a temporary PHP file that has all the blade directives converted to `php` tags, you may set additional breakpoints in this code as well. Do not edit the code in these temporary files as it they be disposed at any time and are only derived for the current debugging session.

If you are having trouble, launch the "Listen for Xdebug" launch configuration again and refresh the preview browser.

<br />

### Tailing the Xdebug Log
You may want to see how Xdebug is working with your server when you are debugging PHP files. 
   1. Open a new terminal in gitpod
   2. Run the command: `tail -f /var/log/xdebug.log`

<br />

## Debugging JavaScript
The is a rather diverse topic. To make a long story short it is possible but very situational.

Have a look at the wiki [debugging JavaScript](https://github.com/apolopena/gitpod-laravel-starter/wiki/Debugging-JavaScript) page for details and exact steps you can take to debug various types of JavaScript.

<br />

## phpMyAdmin

phpMyAdmin is a tool that handles MySQL administration over the web. This tool is very powerful and can be essential when developing MySQL powered systems especially in the cloud. For more information on what phpMyAdmin can do, check out the [official documentation](https://www.phpmyadmin.net/docs/), the [user guide](https://docs.phpmyadmin.net/en/latest/user.html) or just dabble around on the [demo server](https://www.phpmyadmin.net/try/).

### Installing phpMyAdmin
phpMyAdmin is installed automatically by default. A phpMyAdmin installation directive is available in `starter.ini` that allows you to omit the installation if you like.

### Security Concerns

phpMyAdmin also introduces some extra security concerns that you may want to address. If you have installed phpMyAdmin using the install directive in `starter.ini` then by default, two MySQL accounts are created using default passwords stored in version control:

- **pmasu**: This is the 'super user' account that a developer can use to log into phpMyAdmin in order to administer any MySQL database.
     - The default password for the user **pmasu** is: ***123456***
- **pma**: This is the 'control user' that the phpMyAdmin uses internally to manage it's advanced storage features which are enabled by default. This user can only administer the `phpmyadmin` database and should not be used by anyone.
  - The default password the 'control user' **pma** is: ***pmapass***

<br />

### Securing phpMyAdmin

At a minimum the default passwords that phpMyAdmin uses to administer the MySQL databases should be changed right after a Gitpod workspace has been created for the first time. An `update-phpmyadmin-pws` command has been provided that automagically changes the default passwords for you.
<br /><br />
The following steps are required to successfully run the `update-phpmyadmin-pws` command:
   1. Create a file in .gp named `.starter.env`. You can run this command from the project root: `cp .gp/.starter.env.example .gp/.starter.env`
   2. Or Copy and paste all the keys containing `PHPMYADMIN` from `.gp/.starter.env.example` to your blank `.starter.env` file
   3. In `.starter.env`, set your password values for the `PHPMYADMIN` keys and save the file
   4. In a terminal run the alias: `update-phpmyadmin-pws`

<br />

## Generating a CHANGELOG.md Using github-changelog-generator

Keeping track of your changes and releases can easily be automated.
There is an option in `starter-ini` to install [`github-changelog-generator`](https://github.com/github-changelog-generator/github-changelog-generator). 
This option is on by default and additional settings for this option can be found in `starter.ini`.
You can generate a `CHANGELOG.md` by running the command:
`rake changelog`
Currently generating a changelog can only be done when the workspace is built for the first time. See [here](https://github.com/apolopena/gitpod-laravel-starter/issues/57) for more details. See [github-changelog-generator](https://github.com/github-changelog-generator/github-changelog-generator) for documentation.

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

## Project Specific Bash Code and Package Installation
Most of the files in `gitpod-laravel-starter` are core files and should not be altered unless you open PR for `gitpod-laravel-starter` however some files are provided so that you can customize your project even further.
<br />
You are encouraged to put your project specific code in files mentioned below:
### User Editable Files
- `.gp/bash/init-project.sh`
   - Contains some basic scaffolding and examples that you may use in your project.
   - Bash code you would like to run when a workspace is created for the first time (initialization) should added here.
- `.gp/bash/install-project-packages.sh`
   - Packages that you would like installed (via `apt-get`) when the docker image layers are built can be added as a single space delimited string to this file.
   - Any changes made to `.gp/bash/install-project-packages.sh` will require a rebuild of the Docker image layers before the workspace is created for the first time.
   - To rebuild the Docker image layers increment the `INVALIDATE_CACHE` value in `.gitpod/Dockerfile` and push that change to the remote repository
### Migration and Seeding
It is recommended that you migrate and seed your project in this file: `.gp/bash/init-project.sh`.
<br />
[For example](https://github.com/apolopena/qna-demo-skeleton/blob/main/.gp/bash/init-project.sh), the [react preset](#preset-examples) makes use of `.gp/bash/init-project` for [migration and seeding](https://github.com/apolopena/qna-demo-skeleton/blob/main/.gp/bash/init-project.sh).
<br />

## Ruby Gems

Currently until gitpod fixes the [issue](https://github.com/apolopena/gitpod-laravel-starter/issues/57) of ruby gems not persisting across workspace restarts, you can only use rake commands when the workspace is created for the first time.

<br />

## Git Aliases

Git aliases that you would like to add to your project should be added to the [`alias`](https://github.com/apolopena/gitpod-laravel-starter/blob/main/.gp/snippets/git/aliases) file.  

### Emoji-log and Gitmoji
A compilation of git aliases from [Emoji-log](https://github.com/ahmadawais/Emoji-Log) and [Gitmoji](https://gitmoji.dev/) are included, use them as you like from the command line. There is also a separate set of emoji based git aliases that will commit the files with a message and push them to the repository *without* adding the files. Use these aliases for dealing with groups of files that need different commit messages but still need to use to Emoji-log and or Gitmoji standards. You can get a list of all the emoji based git aliases with the command: `git a`

<br />

## Deployment Outside of Gitpod

For now this will be something you need to figure out, eventually some guidelines for how to do that may be added here.

<br />

## Gitpod Caveats
Gitpod is an amazing and dynamic platform however sometimes during it's peak hours, latency can affect the workspace. Here are a few symptoms and their possible remedies. This section will be updated or removed as Gitpod evolves.
  - **Symptom**: Workspace loads, IDE displays, however one or more terminals are blank.
    - **Possible Fix**: Delete the workspace in your Gitpod dashboard and then [recreate the workspace](#creating-a-new-workspace-in-gitpod-from-your-new-github-project-repository).
  - **Symptom**: Workspace loads, IDE displays, however no ports become available and or the spinner stays spinning in the terminal even after a couple of minutes.
    - **Possible Fix**: Refresh the browser

You can also try to remedy any rare Gitpod network hiccups by simply waiting 30 minutes and trying again.

## Thank You

🙏 to the communities of:

- Gitpod
- Laravel
- VS Code
- Xdebug
