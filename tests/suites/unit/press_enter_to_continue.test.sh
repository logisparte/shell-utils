#!/bin/sh

Include "$PWD/src/press_enter_to_continue.sh"

SOME_MESSAGE="Some message"

Describe "press_enter_to_continue"
  report() {
    # shellcheck disable=SC2034
    report_called_with="$*"
    %preserve report_called_with
}

  colorize() {
    printf "%s" "$2"
}

  _read_enter() {
    # shellcheck disable=SC2034
    read_enter_called=true
    %preserve read_enter_called
    true
}

  Context "when no message provided"
    It "should ask to press ENTER to continue"
      When run press_enter_to_continue
      The status should be success
      The variable report_called_with should equal "Press ENTER to continue"
      The variable read_enter_called should equal true
    End
  End

  Context "when a message is provided"
    It "should report the message"
      When run press_enter_to_continue "$SOME_MESSAGE"
      The status should be success
      The variable report_called_with should equal "$SOME_MESSAGE"
      The variable read_enter_called should equal true
    End
  End
End
