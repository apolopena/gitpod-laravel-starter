# Gitpod PHP debugging boilerplate setup *
### Debug PHP in Gitpod using xdebug v3

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


*Thanks to the gitpod community and xdebug!
