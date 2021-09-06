#!/usr/bin/env bash

_current_os=$(uname)

function is_macos_x86() {
  [[ "$_current_os" == "Darwin" && $(uname -p) == 'x86_64' ]]
}

function is_macos_arm() {
  [[ "$_current_os" == "Darwin" && $(uname -p) == 'arm' ]]
}

function is_macos() {
  [[ is_macos_x86 || is_macos_arm ]]
}

function is_linux() {
  [[ "$_current_os" == "Linux" ]]
}
