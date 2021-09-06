#!/usr/bin/env bash

source "${BASH_SOURCE%/*}/installers/shared.sh"

dotheader "Starting setup"

require_installer package-manager
# require_installer terminal
# require_installer tiling
# require_installer mac-app-store
# require_installer mac-custom-apps
require_installer git
require_installer devtools
require_installer zsh
require_installer rust
# require_installer python
# require_installer ruby
# require_installer tmux
# require_installer fonts
require_installer neovim
# require_installer backups
require_installer os-keys
require_installer media
# require_installer personal
# require_installer java
# require_installer monitor
# require_installer chat
