#!/bin/sh
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
