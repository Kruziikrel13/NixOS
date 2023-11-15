#!/usr/bin/env bash
set -eo pipefail

declare -xr CONFIG_PATH="/etc/nixos"

declare BASEDIR
BASEDIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
BASEDIR="$(dirname -- "$BASEDIR")"
readonly BASEDIR

declare -xa LINK_FILES

function check_permissions() {
  if [ "$EUID" -ne 0 ] && [ ! -w "$CONFIG_PATH" ]; then
    echo "Cannot write to $CONFIG_PATH. Please modify permissions or run as root"
    exit 1
  fi
}

function link_local() {
  for file in "${LINK_FILES[@]}"; do
    local base_name
    base_name=$(basename "$file")
    if [ ! -e "$CONFIG_PATH/$base_name" ]; then
      ln -s -f "$file" "$CONFIG_PATH/$base_name"
      echo "$file -> $CONFIG_PATH/$base_name"
    elif [ "$(readlink "$CONFIG_PATH/$base_name")" != "$file" ]; then
      rm -r -f "$CONFIG_PATH/${base_name:?}"
      ln -s -f "$file" "$CONFIG_PATH/$base_name"
    else
      echo "$file Already Linked to $CONFIG_PATH/$base_name"
    fi
  done
}

function __link_files() {
  local files
  files=$(find "$BASEDIR" -maxdepth 1 -type d,f ! -name "*git*" ! -wholename "$BASEDIR")

  for element in $files; do
    LINK_FILES+=("$element")
  done
}

function main() {
  check_permissions
  __link_files

  link_local
}

main "$@"
