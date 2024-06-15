#!/bin/sh

Include "$PWD/src/report.sh"

SOME_MESSAGE="some message"

Describe "report"
  colorize() {
    # shellcheck disable=SC2034
    colorize_called_with="$*"
    %preserve colorize_called_with
    echo "$2"
}

  Describe "default"
    It "should just output message"
      When run report "$SOME_MESSAGE"
      The status should be success
      The output should equal "$SOME_MESSAGE"
      The variable colorize_called_with should be undefined
    End
  End

  Describe "success"
    It "should output message in green"
      When run report --success "$SOME_MESSAGE"
      The status should be success
      The output should equal "$SOME_MESSAGE"
      The variable colorize_called_with should equal "--lime $SOME_MESSAGE"
    End
  End

  Describe "info"
    It "should output message in aqua"
      When run report --info "$SOME_MESSAGE"
      The status should be success
      The output should equal "$SOME_MESSAGE"
      The variable colorize_called_with should equal "--aqua $SOME_MESSAGE"
    End
  End

  Describe "warning"
    It "should output message in yellow"
      When run report --warning "$SOME_MESSAGE"
      The status should be success
      The output should equal "$SOME_MESSAGE"
      The variable colorize_called_with should equal "--yellow $SOME_MESSAGE"
    End
  End

  Describe "error"
    It "should output message in red as error"
      When run report --error "$SOME_MESSAGE"
      The status should be success
      The error should equal "$SOME_MESSAGE"
      The variable colorize_called_with should equal "--red $SOME_MESSAGE"
    End
  End
End
