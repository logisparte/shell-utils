#!/bin/sh

count_unstaged_changes() {
  git diff --name-only | wc -l | xargs
}
