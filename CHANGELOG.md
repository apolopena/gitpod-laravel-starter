# Changelog

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
