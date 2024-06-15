#!/bin/sh

Include "$PWD/src/succeed.sh"

SOME_MESSAGE="Some message"

Describe "succeed"
  report() {
    # shellcheck disable=SC2034
    report_called_with="$*"
    %preserve report_called_with
}

  Context "when no message provided"
    It "should exit successfully without reporting anything"
      When run succeed
      The status should be success
      The variable report_called_with should not be defined
    End
  End

  Context "when a message is provided"
    It "should exit successfully and report message as success"
      When run succeed "$SOME_MESSAGE"
      The status should be success
      The variable report_called_with should equal "--success $SOME_MESSAGE"
    End
  End
End
