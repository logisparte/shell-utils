#!/bin/sh
#
# shell-utils 0.1.0
#
# Copyright 2024 logisparte inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

. ./scripts/utils/get_absolute_directory_path.sh

find_this_directory() {
  EXECUTABLE_FILE_PATH="$(_get_initial_executable_file_path)"

  EXECUTABLE_FILE_PATH="$(_follow_links_to_real_executable "$EXECUTABLE_FILE_PATH")"
  get_absolute_directory_path "$EXECUTABLE_FILE_PATH"
}

_follow_links_to_real_executable() {
  EXECUTABLE_FILE_PATH="$1"

  while _is_symbolic_link "$EXECUTABLE_FILE_PATH"; do
    EXECUTABLE_FILE_PATH="$(_follow_link "$EXECUTABLE_FILE_PATH")"
  done

  echo "$EXECUTABLE_FILE_PATH"
}

_follow_link() {
  EXECUTABLE_FILE_PATH="$1"

  ABSOLUTE_DIRECTORY_PATH="$(get_absolute_directory_path "$EXECUTABLE_FILE_PATH")"
  EXECUTABLE_FILE_PATH="$(_readlink "$EXECUTABLE_FILE_PATH")"

  # If $EXECUTABLE_FILE_PATH was a relative symbolic link, it must be resolved relatively to
  # the path where the symbolic link file was located
  if _does_file_exist "$ABSOLUTE_DIRECTORY_PATH/$EXECUTABLE_FILE_PATH"; then
    EXECUTABLE_FILE_PATH="$ABSOLUTE_DIRECTORY_PATH/$EXECUTABLE_FILE_PATH"
  fi

  echo "$EXECUTABLE_FILE_PATH"
}

# LCOV_EXCL_START
# Memoizing native program path here, otherwise it's strangely not available at runtime
READLINK="$(command -v readlink)"
_readlink() {
  "$READLINK" "$1"
}

_get_initial_executable_file_path() {
  echo "$0"
}

_does_file_exist() {
  [ -f "$1" ]
}

_is_symbolic_link() {
  [ -h "$1" ]
}

# LCOV_EXCL_STOP
