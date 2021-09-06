#!/usr/bin/env bash

# Credit: adapted from @alrra's dotfiles at:
#
#   https://raw.githubusercontent.com/alrra/dotfiles/master/src/os/install/macos/xcode.sh
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

ask() {
  print_question "$1"
  read -r
}

print_question() {
  print_in_yellow "   [?] $1"
}

get_answer() {
  printf "%s" "$REPLY"
}

cmd_exists() {
  command -v "$1" &> /dev/null
}

set_trap() {
  trap -p "$1" | grep "$2" &> /dev/null \
    || trap '$2' "$1"
}

print_header() {
  print_in_purple "\n • $1\n\n"
}

show_spinner() {
  local -r FRAMES='/-\|'

  # shellcheck disable=SC2034
  local -r NUMBER_OR_FRAMES=${#FRAMES}

  local -r CMDS="$2"
  local -r MSG="$3"
  local -r PID="$1"

  local i=0
  local frameText=""

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Note: In order for the Travis CI site to display
  # things correctly, it needs special treatment, hence,
  # the "is Travis CI?" checks.

  if [ "$TRAVIS" != "true" ]; then
    # Provide more space so that the text hopefully
    # doesn't reach the bottom line of the terminal window.
    #
    # This is a workaround for escape sequences not tracking
    # the buffer position (accounting for scrolling).
    #
    # See also: https://unix.stackexchange.com/a/278888

    printf "\n\n\n"
    tput cuu 3

    tput sc
  fi

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Display spinner while the commands are being executed.

  while kill -0 "$PID" &>/dev/null; do
    frameText="   [${FRAMES:i++%NUMBER_OR_FRAMES:1}] $MSG"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Print frame text.

    if [ "$TRAVIS" != "true" ]; then
      printf "%s\n" "$frameText"
    else
      printf "%s" "$frameText"
    fi

    sleep 0.2

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Clear frame text.

    if [ "$TRAVIS" != "true" ]; then
      tput rc
    else
      printf "\r"
    fi

  done
}

kill_all_subprocesses() {
  local i=""

  for i in $(jobs -p); do
    kill "$i"
    wait "$i" &> /dev/null
  done
}

execute() {
  local -r CMDS="$1"
  local -r MSG="${2:-$1}"
  local -r TMP_FILE="$(mktemp /tmp/XXXXX)"

  local exitCode=0
  local cmdsPID=""

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # If the current process is ended,
  # also end all its subprocesses.

  set_trap "EXIT" "kill_all_subprocesses"

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Execute commands in background

  eval "$CMDS" \
    &> /dev/null \
    2> "$TMP_FILE" &

  cmdsPID=$!

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Show a spinner if the commands
  # require more time to complete.

  show_spinner "$cmdsPID" "$CMDS" "$MSG"

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Wait for the commands to no longer be executing
  # in the background, and then get their exit code.

  wait "$cmdsPID" &> /dev/null
  exitCode=$?

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Print output based on what happened.

  print_result $exitCode "$MSG"

  if [ $exitCode -ne 0 ]; then
    print_error_stream < "$TMP_FILE"
  fi

  rm -rf "$TMP_FILE"

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  return $exitCode
}

print_success() {
  print_in_green "   [✔] $1\n"
}

print_error() {
  print_in_red "   [✖] $1 $2\n"
}

print_in_color() {
  printf "%b" \
    "$(tput setaf "$2" 2> /dev/null)" \
    "$1" \
    "$(tput sgr0 2> /dev/null)"
  }

print_in_green() {
  print_in_color "$1" 2
}

print_in_purple() {
  print_in_color "$1" 5
}

print_in_red() {
  print_in_color "$1" 1
}

print_in_yellow() {
  print_in_color "$1" 3
}

print_result() {
  if [ "$1" -eq 0 ]; then
    print_success "$2"
  else
    print_error "$2"
  fi

  return "$1"
}

agree_with_xcode_licence() {
  # Automatically agree to the terms of the `Xcode` license.
  # https://github.com/alrra/dotfiles/issues/10

  sudo xcodebuild -license accept &> /dev/null
  print_result $? "Agree to the terms of the Xcode licence"
}

are_xcode_command_line_tools_installed() {
  xcode-select --print-path &> /dev/null
}

install_xcode() {
  # If necessary, prompt user to install `Xcode`.

  if ! is_xcode_installed; then
    open "macappstores://itunes.apple.com/en/app/xcode/id497799835"
  fi

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Wait until `Xcode` is installed.

  execute \
    "until is_xcode_installed; do \
    sleep 5; \
  done" \
  "Xcode.app"
}

install_xcode_command_line_tools() {
  # If necessary, prompt user to install
  # the `Xcode Command Line Tools`.

  xcode-select --install &> /dev/null

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Wait until the `Xcode Command Line Tools` are installed.

  execute \
    "until are_xcode_command_line_tools_installed; do \
    sleep 5; \
  done" \
  "Xcode Command Line Tools"
}

is_xcode_installed() {
  [ -d "/Applications/Xcode.app" ]
}

set_xcode_developer_directory() {
  # Point the `xcode-select` developer directory to
  # the appropriate directory from within `Xcode.app`.
  #
  # https://github.com/alrra/dotfiles/issues/13

  sudo xcode-select -switch "/Applications/Xcode.app/Contents/Developer" &> /dev/null
  print_result $? "Make 'xcode-select' developer directory point to the appropriate directory from within Xcode.app"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

bootstrap_xcode() {
  if [ -f ~/.config/dotfiles/no-xcode ]; then
    print_header "Skipping Xcode, no-xcode enabled"
  else
    print_header "Installing Xcode..."

    install_xcode_command_line_tools
    install_xcode
    set_xcode_developer_directory
    agree_with_xcode_licence
  fi
}

# ssh - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

add_ssh_configs() {
  printf "%s\n" \
    "Host github.com" \
    "  IdentityFile $1" \
    "  LogLevel ERROR" >> ~/.ssh/config

  print_result $? "Add SSH configs"
}

copy_public_ssh_key_to_clipboard () {
  if cmd_exists "pbcopy"; then
    pbcopy < "$1"
    print_result $? "Copy public SSH key to clipboard"
  elif cmd_exists "xclip"; then
    xclip -selection clip < "$1"
    print_result $? "Copy public SSH key to clipboard"
  else
    print_warning "Please copy the public SSH key ($1) to clipboard"
  fi
}

generate_ssh_keys() {

  ask "Please provide an email address: " && printf "\n"
  ssh-keygen -t rsa -b 4096 -C "$(get_answer)" -f "$1"

  print_result $? "Generate SSH keys"

}

open_github_ssh_page() {
  declare -r GITHUB_SSH_URL="https://github.com/settings/ssh"

  # The order of the following checks matters
  # as on Ubuntu there is also a utility called `open`.

  if cmd_exists "xdg-open"; then
    xdg-open "$GITHUB_SSH_URL"
  elif cmd_exists "open"; then
    open "$GITHUB_SSH_URL"
  else
    print_warning "Please add the public SSH key to GitHub ($GITHUB_SSH_URL)"
  fi
}

set_github_ssh_key() {
  local sshKeyFileName="$HOME/.ssh/github"

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # If there is already a file with that
  # name, generate another, unique, file name.

  if [ -f "$sshKeyFileName" ]; then
    sshKeyFileName="$(mktemp -u "$HOME/.ssh/github_XXXXX")"
  fi

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  generate_ssh_keys "$sshKeyFileName"
  add_ssh_configs "$sshKeyFileName"
  copy_public_ssh_key_to_clipboard "${sshKeyFileName}.pub"
  open_github_ssh_page
  test_ssh_connection
}

test_ssh_connection() {
  while true; do
    ssh -T git@github.com &> /dev/null
    [ $? -eq 1 ] && break

    sleep 5
  done
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_ssh_keys() {
  print_header "Set up GitHub SSH keys"

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  ssh -T git@github.com &> /dev/null

  if [ $? -ne 1 ]; then
    set_github_ssh_key
  fi

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  print_result $? "Set up GitHub SSH keys"
}

# hostname ---------------------------------------

setup_hostname() {
  print_header "Set computer hostname"

  if [[ $(scutil --get HostName 2>/dev/null) == "" ]]; then
    ask "Please enter a hostname: "
    local new_hostname=$(get_answer)

    sudo scutil --set ComputerName "$new_hostname"
    sudo scutil --set LocalHostName "$new_hostname"
    sudo scutil --set HostName "$new_hostname"

    dscacheutil -flushcache

    print_success "Set hostname to $new_hostname"
  else
    print_success "Already set hostname to $(hostname)!"
  fi
}

# clone dotfiles repo

clone_dotfiles_repo() {
  print_header "Cloning dotfiles repo..."

  if [[ -d ~/.dotfiles ]]; then
    print_success "dotfiles repo already cloned to ~/.dotfiles"
  else
    git clone git@github.com:jameslittle230/dotfiles.git ~/.dotfiles
    print_success "cloned dotfile repo"

    echo "Now you can run: cd ~/.dotfiles && ./setup"
  fi
}

run_osx_script() {
  if [[ $(uname) == "Darwin" ]]; then
    print_header "Applying OS X tweaks..."

    $HOME/.dotfiles/osx

    echo
    print_success "OSX tweaks applied"
  fi
}

main() {
  bootstrap_xcode
  setup_ssh_keys
  setup_hostname
  clone_dotfiles_repo
  run_osx_script
}

main