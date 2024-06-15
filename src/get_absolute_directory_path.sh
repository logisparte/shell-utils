#!/bin/sh

get_absolute_directory_path() {
  RELATIVE_FILE="$1"

  cd -P "$(_dirname "$RELATIVE_FILE")" > /dev/null 2>&1 && pwd
}

# LCOV_EXCL_START
# Memoizing native program path here, otherwise it's strangely not available at runtime
DIRNAME="$(command -v dirname)"
_dirname() {
  "$DIRNAME" "$1"
}

# LCOV_EXCL_STOP
