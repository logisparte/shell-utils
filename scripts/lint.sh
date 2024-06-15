#!/bin/sh -e

. ./src/colorize.sh
. ./src/fail.sh
. ./src/git/list_all_files.sh
. ./src/git/list_dirty_files.sh
. ./src/git/list_staged_files.sh
. ./src/report.sh

FILTER="$1"

case "$FILTER" in
  dirty | "")
    report --info "[lint] Linting dirty files only"
    FILES="$(list_dirty_files)"
    ;;

  staged)
    report --info "[lint] Linting staged files only"
    FILES=$(list_staged_files)
    ;;

  all)
    report --info "[lint] Linting all files"
    FILES="$(list_all_files)"
    ;;

  *)
    fail "[lint] Unknown filter: '$FILTER'"
    ;;
esac

MARKDOWN_FILES="$(echo "$FILES" | grep -e "\.md$" || true)"
if [ -n "$MARKDOWN_FILES" ]; then
  report --info "Markdown files >>"
  echo "$MARKDOWN_FILES" | xargs markdownlint
fi

SHELLCHECK_FILES="$(echo "$FILES" | grep -e "\.sh$" || true)"
if [ -n "$SHELLCHECK_FILES" ]; then
  report --info "Shell files >>"
  report "$(colorize --gray "$SHELLCHECK_FILES")"
  echo "$SHELLCHECK_FILES" | xargs shellcheck
fi

report --success "[lint] Done"
