#!/bin/sh -e

. ./src/fail.sh
. ./src/report.sh

COVERAGE_REPORT="$PWD/tests/coverage/index.html"

if ! [ -f "$COVERAGE_REPORT" ]; then
  fail "[coverage] No coverage report found. Run tests with coverage first"
fi

report --info "Coverage report at: "
echo "file://$COVERAGE_REPORT"
