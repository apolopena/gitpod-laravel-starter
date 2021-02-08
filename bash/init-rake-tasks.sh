#!/bin/bash

parse="bash bash/utils.sh parse_ini_value starter.ini"

# BEGIN: dynamic rake task functions
add_changelog_rake() {
  local rake='changelog'
  local project=$(basename $GITPOD_REPO_ROOT)
  local since_tag
  local future_release
  since_tag=$(eval $parse github-changelog-generator since_tag)
  future_release=$(eval $parse github-changelog-generator future_release)

  # this rake task cannot handle empty strings as values so handle them (whitespace is ok though)
  [ -z "$since_tag" ] && default_since_tag='' ||  default_since_tag="config.since_tag = '$since_tag'"
  [ -z "$future_release" ] && default_future_release='' ||  default_future_release="config.future_release = '$future_release'"

# Do not indent the below HEREDOC code block!
IFS='' read -r -d '' __task <<EOF
require 'github_changelog_generator/task'
GitHubChangelogGenerator::RakeTask.new :changelog do |config|
  config.user = '$GITPOD_GIT_USER_NAME'
  config.project = '$project'
  $default_since_tag
  $default_future_release
end
EOF

  bash bash/helpers.sh add_global_rake_task "$__task" "$rake"
}
# END: dynamic rake task functions

# BEGIN: conditionally add dynamic rake tasks 
if [ "$(eval $parse github-changelog-generator install)" ]; then
  add_changelog_rake
  [ $? != 0 ] && exit 1
fi
# END: conditionally add dynamic rake tasks




