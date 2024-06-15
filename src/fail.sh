#!/bin/sh

. ./src/report.sh

fail() {
  MESSAGE="$1"

  if [ -n "$MESSAGE" ]; then
    report --error "$MESSAGE"
  fi

  exit 1
}
