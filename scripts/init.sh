#!/bin/sh -e

. ./src/report.sh

report --info "[init] Configuring git hooks"
git config --local core.hooksPath "$PWD/hooks"

report --info "[init] Setting docker development environment"
./docker/env.sh init

report --success "[init] Done"
