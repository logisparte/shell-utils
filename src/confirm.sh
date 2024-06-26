#!/bin/sh

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
