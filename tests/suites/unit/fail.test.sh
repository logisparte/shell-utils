#!/bin/sh

Include "$PWD/src/fail.sh"

SOME_ERROR_MESSAGE="Some error message"

Describe "fail"
  report() {
    # shellcheck disable=SC2034
    report_called_with="$*"
    %preserve report_called_with
}

  Context "when no error message provided"
    It "should exit in error without reporting anything"
      When run fail
      The status should be failure
      The variable report_called_with should not be defined
    End
  End

  Context "when an error message is provided"
    It "should exit in error and report message as error"
      When run fail "$SOME_ERROR_MESSAGE"
      The status should be failure
      The variable report_called_with should equal "--error $SOME_ERROR_MESSAGE"
    End
  End
End
