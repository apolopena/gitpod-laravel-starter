# This file is sourced into ~/.bashrc
# Add any alias you would like here

# Updates all passwords related to phpmyadmin from values set in .starter.env
# Requires .starter.env to have all phpmyadmin related keys set with values
# Empty string value will break the script
# See .starter.env.example for the required phpmyadmin keys
alias update_pma_pws='bash $GITPOD_REPO_ROOT/bash/change-passwords.sh phpmyadmin'
alias help_update_pma_pws="cat bash/snippets/messages/help-update-pma-pws.txt"