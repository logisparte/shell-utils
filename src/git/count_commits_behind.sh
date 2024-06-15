#!/bin/sh

count_commits_behind() {
  git rev-list --count HEAD..@\{upstream\} 2> /dev/null
}
