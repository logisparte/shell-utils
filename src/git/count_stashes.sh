#!/bin/sh

count_stashes() {
  git stash list | wc -l | xargs
}
