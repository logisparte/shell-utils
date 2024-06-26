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

. ./scripts/utils/colorize.sh
. ./scripts/utils/report.sh

press_enter_to_continue() {
  MESSAGE="${1-"Press ENTER to continue"}"

  report "$(colorize --bold-white "$MESSAGE")"
  _read_enter
}

# LCOV_EXCL_START
_read_enter() {
  read -r _
  unset _
}

# LCOV_EXCL_STOP
