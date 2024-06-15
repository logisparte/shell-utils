#!/bin/sh

count_staged_changes() {
  git diff --staged --name-only | wc -l | xargs
}
