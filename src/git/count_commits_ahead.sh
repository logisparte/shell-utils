#!/bin/sh

count_commits_ahead() {
  git rev-list --count @\{upstream\}..HEAD 2> /dev/null
}
