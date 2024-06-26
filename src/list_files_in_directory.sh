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
