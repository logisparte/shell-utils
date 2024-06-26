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

confirm() {
  case "$1" in
    --yes)
      shift
      AUTO_ANSWER="y"
      ;;

    --no)
      shift
      AUTO_ANSWER="n"
      ;;

    *)
      true
      ;;
  esac

  QUESTION="${1-"Are you sure?"}"
  report "$(colorize --bold-white "$QUESTION") $(colorize --xterm 244 "[y/n]") "

  if _is_interactive; then
    ANSWER="$(_read_answer)"

  elif [ -n "$AUTO_ANSWER" ]; then
    report --info "auto $AUTO_ANSWER"
    ANSWER="$AUTO_ANSWER"

  else
    report --error \
      "[::confirm] Terminal is not interactive and no default answer provided (--yes/--no)"
    exit 1
  fi

  case "$ANSWER" in
    [yY])
      unset ANSWER
      return 0
      ;;

    *)
      unset ANSWER
      return 1
      ;;
  esac
}

# LCOV_EXCL_START
_is_interactive() {
  [ -n "$PS1" ] || [ -t 0 ]
}

_read_answer() {
  read -r ANSWER
  printf "%s" "$ANSWER"
}

# LCOV_EXCL_STOP
