#!/bin/sh -e

. ./src/fail.sh
. ./src/report.sh

TEST_SUITE_DIRECTORY="$PWD/tests/suites"

SUITE_NAME="$1"

if [ -z "$SUITE_NAME" ]; then
  report --info "[test] Running all tests"
  SUITE_PATH="$TEST_SUITE_DIRECTORY"

elif [ -d "$TEST_SUITE_DIRECTORY/$SUITE_NAME" ]; then
  report --info "[test] Running $SUITE_NAME tests"
  SUITE_PATH="$TEST_SUITE_DIRECTORY/$SUITE_NAME"

else
  fail "[test] No test suite named '$SUITE_NAME'"
fi

# bash shell is required because of
# [kcov limitation](https://github.com/SimonKagstrom/kcov/issues/137)
shellspec \
  --shell bash \
  --default-path "$SUITE_PATH" \
  --pattern "*.test.sh" \
  --kcov \
  --kcov-options="--include-pattern=$PWD/src/" \
  --covdir "$PWD/tests/coverage"
