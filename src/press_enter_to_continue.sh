#!/bin/sh

. ./src/colorize.sh
. ./src/report.sh

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
