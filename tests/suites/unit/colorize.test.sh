#!/bin/sh

Include "$PWD/src/colorize.sh"

SOME_TEXT="some text"
SOME_COLOR_CODE=123
SOME_INVALID_COLOR_CODE=454

Describe "colorize"
  Context "when no text or color provided"
    It "should return an empty string"
      When run colorize
      The status should be success
      The output should equal ""
    End
  End

  Context "when no text provided"
    It "should return an empty string"
      When run colorize --white
      The status should be success
      The output should equal ""
    End
  End

  Context "when no color provided"
    It "should return the text in white"
      When run colorize "$SOME_TEXT"
      The status should be success
      The output should equal "$(printf "\033[38;5;15m%s\033[0m" "$SOME_TEXT")"
    End
  End

  Context "when color is invalid"
    SOME_INVALID_COLOR="--some-invalid-color"
    It "should return the text in white"
      When run colorize "$SOME_INVALID_COLOR" "$SOME_TEXT"
      The status should be success
      The output should equal "$(printf "\033[38;5;15m%s\033[0m" "$SOME_TEXT")"
    End
  End

  Context "when NO_COLOR is true"
    It "should return the text as is and ignore color"
      export NO_COLOR=true
      When run colorize --red "$SOME_TEXT"
      The status should be success
      The output should equal "$SOME_TEXT"
      unset NO_COLOR
    End
  End

  Context "when NO_COLOR is 1"
    It "should return the text as is and ignore color"
      export NO_COLOR=1
      When run colorize --red "$SOME_TEXT"
      The status should be success
      The output should equal "$SOME_TEXT"
      unset NO_COLOR
    End
  End

  Context "when color is black"
    It "should return the text in black"
      When run colorize --black "$SOME_TEXT"
      The status should be success
      The output should equal "$(printf "\033[38;5;0m%s\033[0m" "$SOME_TEXT")"
    End
  End

  Context "when color is maroon"
    It "should return the text in maroon"
      When run colorize --maroon "$SOME_TEXT"
      The status should be success
      The output should equal "$(printf "\033[38;5;1m%s\033[0m" "$SOME_TEXT")"
    End
  End

  Context "when color is green"
    It "should return the text in green"
      When run colorize --green "$SOME_TEXT"
      The status should be success
      The output should equal "$(printf "\033[38;5;2m%s\033[0m" "$SOME_TEXT")"
    End
  End

  Context "when color is olive"
    It "should return the text in olive"
      When run colorize --olive "$SOME_TEXT"
      The status should be success
      The output should equal "$(printf "\033[38;5;3m%s\033[0m" "$SOME_TEXT")"
    End
  End

  Context "when color is navy"
    It "should return the text in navy"
      When run colorize --navy "$SOME_TEXT"
      The status should be success
      The output should equal "$(printf "\033[38;5;4m%s\033[0m" "$SOME_TEXT")"
    End
  End

  Context "when color is purple"
    It "should return the text in purple"
      When run colorize --purple "$SOME_TEXT"
      The status should be success
      The output should equal "$(printf "\033[38;5;5m%s\033[0m" "$SOME_TEXT")"
    End
  End

  Context "when color is teal"
    It "should return the text in teal"
      When run colorize --teal "$SOME_TEXT"
      The status should be success
      The output should equal "$(printf "\033[38;5;6m%s\033[0m" "$SOME_TEXT")"
    End
  End

  Context "when color is silver"
    It "should return the text in silver"
      When run colorize --silver "$SOME_TEXT"
      The status should be success
      The output should equal "$(printf "\033[38;5;7m%s\033[0m" "$SOME_TEXT")"
    End
  End

  Context "when color is gray"
    It "should return the text in gray"
      When run colorize --gray "$SOME_TEXT"
      The status should be success
      The output should equal "$(printf "\033[38;5;8m%s\033[0m" "$SOME_TEXT")"
    End
  End

  Context "when color is red"
    It "should return the text in red"
      When run colorize --red "$SOME_TEXT"
      The status should be success
      The output should equal "$(printf "\033[38;5;9m%s\033[0m" "$SOME_TEXT")"
    End
  End

  Context "when color is lime"
    It "should return the text in lime"
      When run colorize --lime "$SOME_TEXT"
      The status should be success
      The output should equal "$(printf "\033[38;5;10m%s\033[0m" "$SOME_TEXT")"
    End
  End

  Context "when color is yellow"
    It "should return the text in yellow"
      When run colorize --yellow "$SOME_TEXT"
      The status should be success
      The output should equal "$(printf "\033[38;5;11m%s\033[0m" "$SOME_TEXT")"
    End
  End

  Context "when color is blue"
    It "should return the text in blue"
      When run colorize --blue "$SOME_TEXT"
      The status should be success
      The output should equal "$(printf "\033[38;5;12m%s\033[0m" "$SOME_TEXT")"
    End
  End

  Context "when color is fuchsia"
    It "should return the text in fuchsia"
      When run colorize --fuchsia "$SOME_TEXT"
      The status should be success
      The output should equal "$(printf "\033[38;5;13m%s\033[0m" "$SOME_TEXT")"
    End
  End

  Context "when color is aqua"
    It "should return the text in aqua"
      When run colorize --aqua "$SOME_TEXT"
      The status should be success
      The output should equal "$(printf "\033[38;5;14m%s\033[0m" "$SOME_TEXT")"
    End
  End

  Context "when color is white"
    It "should return the text in white"
      When run colorize --white "$SOME_TEXT"
      The status should be success
      The output should equal "$(printf "\033[38;5;15m%s\033[0m" "$SOME_TEXT")"
    End
  End

  Context "when color is bold-white"
    It "should return the text in bold-white"
      When run colorize --bold-white "$SOME_TEXT"
      The status should be success
      The output should equal "$(printf "\033[38;1;15m%s\033[0m" "$SOME_TEXT")"
    End
  End

  Context "when color is xterm"
    Context "when no color code is provided"
      It "should return the text in white"
        When run colorize --xterm "$SOME_TEXT"
        The status should be success
        The output should equal "$(printf "\033[38;5;15m%s\033[0m" "$SOME_TEXT")"
      End
    End

    Context "when an invalid color code is provided"
      It "should return the text prefixed with the invalid color in white"
        When run colorize --xterm "$SOME_INVALID_COLOR_CODE" "$SOME_TEXT"
        The status should be success
        The output should equal \
          "$(printf "\033[38;5;15m%s\033[0m" "$SOME_INVALID_COLOR_CODE $SOME_TEXT")"
      End
    End

    Context "when an a valid color code is provided"
      It "should return the text in the provided xterm color code"
        When run colorize --xterm "$SOME_COLOR_CODE" "$SOME_TEXT"
        The status should be success
        The output should equal \
          "$(printf "\033[38;5;${SOME_COLOR_CODE}m%s\033[0m" "$SOME_TEXT")"
      End
    End
  End
End
