# Changelog

## [v1.4.0](https://github.com/apolopena/gitpod-laravel-starter/tree/v1.4.0) (2022-01-28)

[Full Changelog](https://github.com/apolopena/gitpod-laravel-starter/compare/v1.3.0...v1.4.0)

**Implemented enhancements:**

- starter.ini: Allow the choice of which PPA to use for an optional install of PHP [\#172](https://github.com/apolopena/gitpod-laravel-starter/issues/172)
- Add GnuPG Support to sign git commits [\#170](https://github.com/apolopena/gitpod-laravel-starter/issues/170)
- Add an option in starter.ini to generate a phpinfo.php to /public [\#168](https://github.com/apolopena/gitpod-laravel-starter/issues/168)
- Auto activate intelephense if license key is available [\#165](https://github.com/apolopena/gitpod-laravel-starter/issues/165)
- Add PHP version to Project powered by and Summary [\#158](https://github.com/apolopena/gitpod-laravel-starter/issues/158)
- Consolidate docker layers in .gitpod.Dockerfile [\#157](https://github.com/apolopena/gitpod-laravel-starter/issues/157)
- starter.ini: Make the PHP version configurable [\#156](https://github.com/apolopena/gitpod-laravel-starter/issues/156)

**Fixed bugs:**

- Unable to install github-changelog-generator gem on Ruby \< 3.0 [\#190](https://github.com/apolopena/gitpod-laravel-starter/issues/190)
- React example presets may not work properly with Laravel version \< 8 [\#186](https://github.com/apolopena/gitpod-laravel-starter/issues/186)
- Make react example presets use their own package.json [\#185](https://github.com/apolopena/gitpod-laravel-starter/issues/185)
- React example presets have some bad css/sass [\#184](https://github.com/apolopena/gitpod-laravel-starter/issues/184)
- Leading and trailing whitespace for values in starter.ini can break the system [\#174](https://github.com/apolopena/gitpod-laravel-starter/issues/174)
- starter.ini: Make VS-Code IDE Preview \(tab\) setting a configurable option. [\#161](https://github.com/apolopena/gitpod-laravel-starter/issues/161)
- xdebug cannot be installed because the base image has been updated to php8. [\#155](https://github.com/apolopena/gitpod-laravel-starter/issues/155)
- workspace-init-logger.sh does an error when ran outside the project root [\#148](https://github.com/apolopena/gitpod-laravel-starter/issues/148)

**Closed issues:**

- Remove hotfix 140 [\#188](https://github.com/apolopena/gitpod-laravel-starter/issues/188)
- Document user editable files and suggested use of init-project.sh for migration and seeding [\#183](https://github.com/apolopena/gitpod-laravel-starter/issues/183)
- Question about Database Migration  [\#182](https://github.com/apolopena/gitpod-laravel-starter/issues/182)
- Add info about install-project-packages.sh to README [\#181](https://github.com/apolopena/gitpod-laravel-starter/issues/181)
- Clarify which values in starter.ini require a docker image rebuild. [\#180](https://github.com/apolopena/gitpod-laravel-starter/issues/180)
- Update README with information about configuring the PPA for optional install of PHP [\#177](https://github.com/apolopena/gitpod-laravel-starter/issues/177)
- Update README with information about configuring GPG keys and Intelliphense [\#176](https://github.com/apolopena/gitpod-laravel-starter/issues/176)
- Update README with information about configuring the version of PHP [\#173](https://github.com/apolopena/gitpod-laravel-starter/issues/173)
- DevX: Normalize line endings in git [\#164](https://github.com/apolopena/gitpod-laravel-starter/issues/164)
- Docs: setting breakpoints, Threads panel is now the CALL STACK panel [\#160](https://github.com/apolopena/gitpod-laravel-starter/issues/160)
- Typo in README [\#153](https://github.com/apolopena/gitpod-laravel-starter/issues/153)
- Fix usage comment for add\_file\_to\_file\_after\(\) in utils.sh [\#152](https://github.com/apolopena/gitpod-laravel-starter/issues/152)
- Fix mispelling in before-tasks.sh header comment [\#151](https://github.com/apolopena/gitpod-laravel-starter/issues/151)
- img tags in readme for powered by needs correction [\#150](https://github.com/apolopena/gitpod-laravel-starter/issues/150)
- Fix multitail value comment in starter.ini [\#149](https://github.com/apolopena/gitpod-laravel-starter/issues/149)
- update-pma-pws-help: recommended command is wrong [\#147](https://github.com/apolopena/gitpod-laravel-starter/issues/147)
- WIKI \[setup page\]: Reword The Developer section [\#146](https://github.com/apolopena/gitpod-laravel-starter/issues/146)
- Comment header in start-server.sh is incorrect [\#145](https://github.com/apolopena/gitpod-laravel-starter/issues/145)

**Merged pull requests:**

- 🚀 RELEASE: Version 1.4.0 - Hotfix 190 [\#191](https://github.com/apolopena/gitpod-laravel-starter/pull/191) ([apolopena](https://github.com/apolopena))
- 🚀 RELEASE: Version 1.4.0 [\#189](https://github.com/apolopena/gitpod-laravel-starter/pull/189) ([apolopena](https://github.com/apolopena))

## [v1.3.0](https://github.com/apolopena/gitpod-laravel-starter/tree/v1.3.0) (2021-05-22)

[Full Changelog](https://github.com/apolopena/gitpod-laravel-starter/compare/v1.2.0...v1.3.0)

**Implemented enhancements:**

- Make EXAMPLE presets be legitimate starting points [\#142](https://github.com/apolopena/gitpod-laravel-starter/issues/142)
- Add a Typescript EXAMPLE 3 and 4: Questions and Answers React Typescript Web Feature [\#139](https://github.com/apolopena/gitpod-laravel-starter/issues/139)
- Add  -\<port number\>  and --help options to op command [\#138](https://github.com/apolopena/gitpod-laravel-starter/issues/138)

**Fixed bugs:**

- init-project.sh should not have a copyright in the header [\#141](https://github.com/apolopena/gitpod-laravel-starter/issues/141)

**Closed issues:**

- Update EXAMPLE 1 and 2  to match the refactored code in EXAMPLE 3 and 4 [\#143](https://github.com/apolopena/gitpod-laravel-starter/issues/143)
- Compliation of saas \>= 1.33.0 outputs DEPRECATION WARNING: Using / for division [\#140](https://github.com/apolopena/gitpod-laravel-starter/issues/140)

**Merged pull requests:**

- 🚀 RELEASE: Version 1.3.0 [\#144](https://github.com/apolopena/gitpod-laravel-starter/pull/144) ([apolopena](https://github.com/apolopena))

## [v1.2.0](https://github.com/apolopena/gitpod-laravel-starter/tree/v1.2.0) (2021-05-10)

[Full Changelog](https://github.com/apolopena/gitpod-laravel-starter/compare/v1.1.0...v1.2.0)

**Implemented enhancements:**

- Allow for easy persistent configuration of apache [\#135](https://github.com/apolopena/gitpod-laravel-starter/issues/135)
- Add a directive to starter.ini: laravel: include\_readme [\#128](https://github.com/apolopena/gitpod-laravel-starter/issues/128)

**Fixed bugs:**

- apache: rewriting the missing trailing slash when in an iframe breaks the page [\#134](https://github.com/apolopena/gitpod-laravel-starter/issues/134)
- nginx: rewriting the missing trailing slash when in an iframe breaks the page [\#131](https://github.com/apolopena/gitpod-laravel-starter/issues/131)
- op: opening url paths that end in a file name gives a 404 [\#130](https://github.com/apolopena/gitpod-laravel-starter/issues/130)
- Fix bad logic for initially moving project files such as README.md [\#127](https://github.com/apolopena/gitpod-laravel-starter/issues/127)

**Closed issues:**

- Bump Xdebug to v3.0.4 [\#129](https://github.com/apolopena/gitpod-laravel-starter/issues/129)

**Merged pull requests:**

- 🚀 RELEASE: Version 1.2.0 [\#136](https://github.com/apolopena/gitpod-laravel-starter/pull/136) ([apolopena](https://github.com/apolopena))

## [v1.0.0](https://github.com/apolopena/gitpod-laravel-starter/tree/v1.0.0) (2021-04-26)

[Full Changelog](https://github.com/apolopena/gitpod-laravel-starter/compare/v0.0.4...v1.0.0)

**Implemented enhancements:**

- include Laravel and laravel/ui version in Init summary [\#110](https://github.com/apolopena/gitpod-laravel-starter/issues/110)
- allow\_mixed\_web directive in starter.ini  [\#109](https://github.com/apolopena/gitpod-laravel-starter/issues/109)
- Provide a Vue EXAMPLE [\#105](https://github.com/apolopena/gitpod-laravel-starter/issues/105)
- Make the version of Laravel configurable in starter.ini [\#102](https://github.com/apolopena/gitpod-laravel-starter/issues/102)
- Support Laravel 6, 7 and future major releases [\#101](https://github.com/apolopena/gitpod-laravel-starter/issues/101)
- ♻️ REFACTOR: bash scripts to pass shellcheck [\#93](https://github.com/apolopena/gitpod-laravel-starter/issues/93)
- Support Nginx and php-fpm [\#89](https://github.com/apolopena/gitpod-laravel-starter/issues/89)
- Add shellcheck [\#88](https://github.com/apolopena/gitpod-laravel-starter/issues/88)
- Implement LICENSE files for third party software [\#86](https://github.com/apolopena/gitpod-laravel-starter/issues/86)
- \[DEMO\] React Example without phpMyAdmin and no extras [\#84](https://github.com/apolopena/gitpod-laravel-starter/issues/84)
- Give this project a license [\#81](https://github.com/apolopena/gitpod-laravel-starter/issues/81)
- \[DEMO\] React QnA, full featured and barebones [\#80](https://github.com/apolopena/gitpod-laravel-starter/issues/80)
- DEMO/EXAMPLE mode [\#79](https://github.com/apolopena/gitpod-laravel-starter/issues/79)
- Init summary: colorize errors and successes [\#75](https://github.com/apolopena/gitpod-laravel-starter/issues/75)
- starter.ini add react-router and react-router-dom [\#36](https://github.com/apolopena/gitpod-laravel-starter/issues/36)

**Fixed bugs:**

- Calling debug\_on without an argument should use the default server [\#111](https://github.com/apolopena/gitpod-laravel-starter/issues/111)
- Only the major version is respected for Laravel install [\#107](https://github.com/apolopena/gitpod-laravel-starter/issues/107)
- Vue EXAMPLE does not work properly in an iframe \(preview browser\) [\#106](https://github.com/apolopena/gitpod-laravel-starter/issues/106)
- lint-starter has no success message [\#100](https://github.com/apolopena/gitpod-laravel-starter/issues/100)
- Xdebug does not work in vscode [\#99](https://github.com/apolopena/gitpod-laravel-starter/issues/99)
- nginx redirects urls with no trailing slash to a 404 [\#96](https://github.com/apolopena/gitpod-laravel-starter/issues/96)
- The spinner in terminal during initialization shows garbage text [\#95](https://github.com/apolopena/gitpod-laravel-starter/issues/95)
- phpmyadmin wont display in an iframe [\#94](https://github.com/apolopena/gitpod-laravel-starter/issues/94)
- debug mode does not work with nginx [\#92](https://github.com/apolopena/gitpod-laravel-starter/issues/92)
-  bash directory in the root is opinionated [\#91](https://github.com/apolopena/gitpod-laravel-starter/issues/91)
- nginx server requires trailing slash locations like phpmyadmin [\#90](https://github.com/apolopena/gitpod-laravel-starter/issues/90)
- vscode IDE preview browser does not open [\#87](https://github.com/apolopena/gitpod-laravel-starter/issues/87)
- LICENSE file is in the way [\#83](https://github.com/apolopena/gitpod-laravel-starter/issues/83)
- Restarting a workspaces gives an error when opening the preview [\#19](https://github.com/apolopena/gitpod-laravel-starter/issues/19)

**Closed issues:**

- Create the wiki - home page and setup page [\#114](https://github.com/apolopena/gitpod-laravel-starter/issues/114)
- Remove support to configure the version of Vue in starter.ini [\#113](https://github.com/apolopena/gitpod-laravel-starter/issues/113)
- Docker image can build a different version of laravel that what is in VCS [\#112](https://github.com/apolopena/gitpod-laravel-starter/issues/112)
- ~ is not supported when setting a Laravel version in starter.ini [\#108](https://github.com/apolopena/gitpod-laravel-starter/issues/108)
- Change repository name to gitpod-laravel-starter [\#104](https://github.com/apolopena/gitpod-laravel-starter/issues/104)
- Document laravel version options [\#103](https://github.com/apolopena/gitpod-laravel-starter/issues/103)
- Refactor snippets and .bashrc functions [\#98](https://github.com/apolopena/gitpod-laravel-starter/issues/98)
- Document nginx server [\#97](https://github.com/apolopena/gitpod-laravel-starter/issues/97)
- Document EXAMPLE mode [\#85](https://github.com/apolopena/gitpod-laravel-starter/issues/85)
- ♻️ REFACTOR: log wrappers for init-workspace.log [\#82](https://github.com/apolopena/gitpod-laravel-starter/issues/82)

**Merged pull requests:**

- 🔀 MERGE: Features, Fixes, Docs and Tasks for version 1.0.0 [\#115](https://github.com/apolopena/gitpod-laravel-starter/pull/115) ([apolopena](https://github.com/apolopena))

## [v0.0.4](https://github.com/apolopena/gitpod-laravel8-starter/tree/v0.0.4) (2021-03-29)

[Full Changelog](https://github.com/apolopena/gitpod-laravel8-starter/compare/v0.0.3...v0.0.4)

**Implemented enhancements:**

- Update npm to version 7.7.5 if needed [\#77](https://github.com/apolopena/gitpod-laravel8-starter/issues/77)
- Init summary: colorize errors and successes [\#75](https://github.com/apolopena/gitpod-laravel8-starter/issues/75)
- Add alias for help on how to use the alias update\_pma\_pws [\#68](https://github.com/apolopena/gitpod-laravel8-starter/issues/68)
- Add phpMyAdmin section to README.md [\#66](https://github.com/apolopena/gitpod-laravel8-starter/issues/66)
- Add a log message to the summary about securing phpmyadmin passwords [\#65](https://github.com/apolopena/gitpod-laravel8-starter/issues/65)
- Support .starter.env for sensitive data like phpmyadmin credentials [\#64](https://github.com/apolopena/gitpod-laravel8-starter/issues/64)
- Environment variables for things like phpmyadmin [\#59](https://github.com/apolopena/gitpod-laravel8-starter/issues/59)
- Readme: Revamp and add TOC [\#58](https://github.com/apolopena/gitpod-laravel8-starter/issues/58)
- Expand Gitlog with additional emoji and git aliases [\#39](https://github.com/apolopena/gitpod-laravel8-starter/issues/39)

**Fixed bugs:**

- front end scaffolding installations throw a npm error [\#76](https://github.com/apolopena/gitpod-laravel8-starter/issues/76)
- phpmyadmin install directive gets cached in the workspace image [\#74](https://github.com/apolopena/gitpod-laravel8-starter/issues/74)
- React and Vue projects only run on php dev server, fail on apache [\#69](https://github.com/apolopena/gitpod-laravel8-starter/issues/69)
- 'before' tasks should be logged to file but not to the console [\#67](https://github.com/apolopena/gitpod-laravel8-starter/issues/67)
- log functions in utils.sh cannot handle a string that starts with -- [\#63](https://github.com/apolopena/gitpod-laravel8-starter/issues/63)
- yarn install and laravel mix called more times than needed during gitpod initialization [\#61](https://github.com/apolopena/gitpod-laravel8-starter/issues/61)
- phpmyadmin: The phpMyAdmin configuration storage is not completely configured [\#60](https://github.com/apolopena/gitpod-laravel8-starter/issues/60)
- Gitpod Internal: Cannot start apache [\#46](https://github.com/apolopena/gitpod-laravel8-starter/issues/46)
- phpmyadmin warning: The configuration file now needs a secret passphrase \(blowfish\_secret\) [\#45](https://github.com/apolopena/gitpod-laravel8-starter/issues/45)
- Change test-app to laravel8-starter [\#41](https://github.com/apolopena/gitpod-laravel8-starter/issues/41)

**Merged pull requests:**

- MERGE: More Features and Fixes for version 0.0.4 [\#78](https://github.com/apolopena/gitpod-laravel8-starter/pull/78) ([apolopena](https://github.com/apolopena))
- Restore default installations [\#73](https://github.com/apolopena/gitpod-laravel8-starter/pull/73) ([apolopena](https://github.com/apolopena))
- ⚰️ REMOVE: no longer needed clear.term.sh [\#72](https://github.com/apolopena/gitpod-laravel8-starter/pull/72) ([apolopena](https://github.com/apolopena))
- Added Gitpod Caveats to TOC in README [\#71](https://github.com/apolopena/gitpod-laravel8-starter/pull/71) ([apolopena](https://github.com/apolopena))
- 🔀 MERGE: Features and Fixes for version 0.0.4 [\#70](https://github.com/apolopena/gitpod-laravel8-starter/pull/70) ([apolopena](https://github.com/apolopena))
- 🐛 FIX: make tail the default apache log monitor [\#56](https://github.com/apolopena/gitpod-laravel8-starter/pull/56) ([apolopena](https://github.com/apolopena))
- Fixes and Features [\#55](https://github.com/apolopena/gitpod-laravel8-starter/pull/55) ([apolopena](https://github.com/apolopena))

## [v0.0.3](https://github.com/apolopena/gitpod-laravel8-starter/tree/v0.0.3) (2021-03-07)

[Full Changelog](https://github.com/apolopena/gitpod-laravel8-starter/compare/v0.0.2...v0.0.3)

**Implemented enhancements:**

- Make the apache log monitor binary configurable in starter.ini [\#54](https://github.com/apolopena/gitpod-laravel8-starter/issues/54)
- Add bash scaffolding for project specific bash code during the init command [\#43](https://github.com/apolopena/gitpod-laravel8-starter/issues/43)
- configuration options for out of the box .editorconfig [\#34](https://github.com/apolopena/gitpod-laravel8-starter/issues/34)
- Command to show pretty results of initialization / workspace image build [\#32](https://github.com/apolopena/gitpod-laravel8-starter/issues/32)
- File persistence system for files outside the repository [\#31](https://github.com/apolopena/gitpod-laravel8-starter/issues/31)

**Fixed bugs:**

- Multitail wont start when apache is launched when terminal window is too small [\#53](https://github.com/apolopena/gitpod-laravel8-starter/issues/53)
- Apache fails to start, cannot find public folder [\#52](https://github.com/apolopena/gitpod-laravel8-starter/issues/52)
- No install of node packages when project is initialized [\#50](https://github.com/apolopena/gitpod-laravel8-starter/issues/50)
- Conditionally create mysql database: laravel [\#49](https://github.com/apolopena/gitpod-laravel8-starter/issues/49)
- Fix and cleanup phpmyadmin [\#48](https://github.com/apolopena/gitpod-laravel8-starter/issues/48)
- php install errors when a workspace image is built [\#47](https://github.com/apolopena/gitpod-laravel8-starter/issues/47)
- Do not open preview until the entire init sequence has completed [\#44](https://github.com/apolopena/gitpod-laravel8-starter/issues/44)
- .gitignore is merged even if it does not need to be. [\#42](https://github.com/apolopena/gitpod-laravel8-starter/issues/42)
- Missing and overwritten scaffolding files when scaffolding is already in VCS [\#40](https://github.com/apolopena/gitpod-laravel8-starter/issues/40)
- .gitignore Laravel Mix artifacts [\#38](https://github.com/apolopena/gitpod-laravel8-starter/issues/38)
- php \(or laravel\) dev server is required for Laravel projects using React [\#37](https://github.com/apolopena/gitpod-laravel8-starter/issues/37)

**Merged pull requests:**

- Fixes and enhancements [\#51](https://github.com/apolopena/gitpod-laravel8-starter/pull/51) ([apolopena](https://github.com/apolopena))
- Feature \#34 [\#35](https://github.com/apolopena/gitpod-laravel8-starter/pull/35) ([apolopena](https://github.com/apolopena))

## [v0.0.2](https://github.com/apolopena/gitpod-laravel8-starter/tree/v0.0.2) (2021-02-08)

[Full Changelog](https://github.com/apolopena/gitpod-laravel8-starter/compare/v0.0.1a...v0.0.2)

**Implemented enhancements:**

- Command to show pretty results of initialization / workspace image build [\#32](https://github.com/apolopena/gitpod-laravel8-starter/issues/32)
- File persistence system for files outside the repository [\#31](https://github.com/apolopena/gitpod-laravel8-starter/issues/31)

- Add CHANGELOG [\#27](https://github.com/apolopena/gitpod-laravel8-starter/issues/27)
- Colorized spinner and  initialization summary [\#25](https://github.com/apolopena/gitpod-laravel8-starter/issues/25)
- Autogenerating CHANGELOG.md capability [\#23](https://github.com/apolopena/gitpod-laravel8-starter/issues/23)
- Optional installs of react, vue and bootstrap [\#20](https://github.com/apolopena/gitpod-laravel8-starter/issues/20)
- Remove query parameter from the url for debug-on and debug-off [\#17](https://github.com/apolopena/gitpod-laravel8-starter/issues/17)
- debug-on and debug-off commands should support apache [\#15](https://github.com/apolopena/gitpod-laravel8-starter/issues/15)
- Make the web server that is used by default configurable [\#14](https://github.com/apolopena/gitpod-laravel8-starter/issues/14)
- \[gitpod\] Starting and stopping apache and php dev server [\#13](https://github.com/apolopena/gitpod-laravel8-starter/issues/13)
- Starter Configuration - phpmyadmin [\#8](https://github.com/apolopena/gitpod-laravel8-starter/issues/8)
- Implement emoji-log standards to the Gitpod environment [\#6](https://github.com/apolopena/gitpod-laravel8-starter/issues/6)

**Fixed bugs:**

- Anything written to ~/ does not persist. ~/.gitconfig, ~/.rake, etc.. [\#30](https://github.com/apolopena/gitpod-laravel8-starter/issues/30)
- phpmyadmin install configuration only works the very first time [\#28](https://github.com/apolopena/gitpod-laravel8-starter/issues/28)
- Gitpod initialization messages are out of order [\#24](https://github.com/apolopena/gitpod-laravel8-starter/issues/24)
- No gitpod init log [\#21](https://github.com/apolopena/gitpod-laravel8-starter/issues/21)
- Move alias and function creation to .gitpod.Dockerfile [\#16](https://github.com/apolopena/gitpod-laravel8-starter/issues/16)
- 9660+ extra files in phpmyadmin install [\#10](https://github.com/apolopena/gitpod-laravel8-starter/issues/10)
- No .gitignore in the root of the project. [\#9](https://github.com/apolopena/gitpod-laravel8-starter/issues/9)
- Project scaffolding conflicts after first push [\#3](https://github.com/apolopena/gitpod-laravel8-starter/issues/3)
- Make MySql graceful when using gitpod/workspace-mysql on the first run [\#1](https://github.com/apolopena/gitpod-laravel8-starter/issues/1)

**Closed issues:**

- Update documentation for version 0.0.2 release [\#5](https://github.com/apolopena/gitpod-laravel8-starter/issues/5)

**Merged pull requests:**

- Features \#31 and \#32, Fixes \#30 [\#33](https://github.com/apolopena/gitpod-laravel8-starter/pull/33) ([apolopena](https://github.com/apolopena))
- Update Readme for 0.0.2 release [\#29](https://github.com/apolopena/gitpod-laravel8-starter/pull/29) ([apolopena](https://github.com/apolopena))
- Features \#25, \#23 and Fixes  \#21 and \#24 [\#26](https://github.com/apolopena/gitpod-laravel8-starter/pull/26) ([apolopena](https://github.com/apolopena))
- Feature \#20: optional installs of react, vue and bootstrap [\#22](https://github.com/apolopena/gitpod-laravel8-starter/pull/22) ([apolopena](https://github.com/apolopena))
- Features and Fixes: \#13 to \#17 [\#18](https://github.com/apolopena/gitpod-laravel8-starter/pull/18) ([apolopena](https://github.com/apolopena))
- Feature \#8 Starter Confiuration \(phpmyadmin\) [\#12](https://github.com/apolopena/gitpod-laravel8-starter/pull/12) ([apolopena](https://github.com/apolopena))
- Fix \#3 and Feature \#6 [\#7](https://github.com/apolopena/gitpod-laravel8-starter/pull/7) ([apolopena](https://github.com/apolopena))

## [v0.0.1a](https://github.com/apolopena/gitpod-laravel8-starter/tree/v0.0.1a) (2021-01-27)

[Full Changelog](https://github.com/apolopena/gitpod-laravel8-starter/compare/c47fbdc6ba57643370bdf32e52ab9854370961cc...v0.0.1a)

**Merged pull requests:**

- Graceful MySql [\#2](https://github.com/apolopena/gitpod-laravel8-starter/pull/2) ([apolopena](https://github.com/apolopena))