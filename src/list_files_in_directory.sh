#!/bin/sh

list_files_in_directory() {
  DIRECTORY="$1"

  for FILE in "$DIRECTORY"/*; do
    if [ "$FILE" != "$DIRECTORY/*" ] && _is_file "$FILE"; then
      basename "$FILE"
    fi
  done
}

# LCOV_EXCL_START
_is_file() {
  [ -f "$1" ]
}

# LCOV_EXCL_STOP
