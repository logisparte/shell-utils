#!/bin/sh

. ./src/report.sh

succeed() {
  MESSAGE="$1"

  if [ -n "$MESSAGE" ]; then
    report --success "$MESSAGE"
  fi

  exit 0
}
