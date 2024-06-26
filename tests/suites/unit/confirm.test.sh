#!/bin/sh

Include "$PWD/src/confirm.sh"

SOME_QUESTION="Some question?"

Describe "confirm"
  report() {
    # shellcheck disable=SC2034
    report_called_with="$*"
    %preserve report_called_with
}

  colorize() {
    for LAST in "$@"; do
      true
  done

    printf "%s" "$LAST"
}

  _is_interactive() {
    [ "$IS_INTERACTIVE" = "true" ]
}

  _read_answer() {
    # shellcheck disable=SC2034
    read_answer_called_with="$*"
    %preserve read_answer_called_with
    printf "%s" "$SOME_ANSWER"
}

  Context "when no auto-answer flag provided"
    Context "when no interactive terminal detected"
      IS_INTERACTIVE=false

      It "should fail with the expected error message"
        When run confirm
        The status should be failure
        The variable report_called_with should end with "$(
                                                           echo \
          "--error" \
          "[::confirm] Terminal is not interactive and no default answer provided" \
          "(--yes/--no)"
)"

      End
    End

    Context "when terminal is interactive"
      IS_INTERACTIVE=true

      Context "when answer is 'y'"
        SOME_ANSWER="y"

        It "should return true"
          When run confirm
          The status should be success
        End
      End

      Context "when answer is 'n'"
        SOME_ANSWER="n"

        It "should return false"
          When run confirm
          The status should be failure
        End
      End

      Context "when answer is anything else"
        SOME_ANSWER="jj"

        It "should return false"
          When run confirm
          The status should be failure
        End
      End

      Context "when no question provided"
        It "should ask 'Are you sure?'"
          When run confirm
          The status should be present
          The variable report_called_with should equal "Are you sure? [y/n] "
        End
      End

      Context "when a question is provided"
        It "should ask the provided question"
          When run confirm "$SOME_QUESTION"
          The status should be present
          The variable report_called_with should equal "$SOME_QUESTION [y/n] "
        End
      End
    End
  End

  Context "when an auto-answer flag is provided"
    Context "when terminal is interactive"
      IS_INTERACTIVE=true
      SOME_ANSWER="y"

      It "should still read answer from terminal"
        When run confirm --yes
        The status should be present
        The variable read_answer_called_with should be defined
      End
    End

    Context "when no interactive terminal detected"
      IS_INTERACTIVE=false

      It "should not read answer from terminal"
        When run confirm --yes
        The status should be present
        The variable read_answer_called_with should not be defined
      End

      Describe "when the auto flag is --yes"
        It "should return true"
          When run confirm --yes
          The status should be success
        End
      End

      Describe "when the auto flag is --no"
        It "should return false"
          When run confirm --no
          The status should be failure
        End
      End
    End
  End
End
