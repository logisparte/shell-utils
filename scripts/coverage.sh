#!/bin/sh -e

. ./scripts/utils/report.sh

COVERAGE_REPORT="$PWD/tests/coverage/index.html"

if ! [ -f "$COVERAGE_REPORT" ]; then
  report --error "[coverage] No coverage report found. Run tests with coverage first"
  exit 1
fi

report --info "Coverage report at: "
echo "file://$COVERAGE_REPORT"
