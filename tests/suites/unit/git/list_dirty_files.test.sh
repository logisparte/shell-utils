#!/bin/sh

Include "$PWD/src/git/list_dirty_files.sh"

SOME_FILE="/some_directory/some_file"
SOME_RENAMED_FILE="/some_directory/some_renamed_file"
UNTRACKED="??"
ADDED="A "
ADDED_MODIFIED="AM"
UNSTAGED_MODIFIED=" M"
STAGED_MODIFIED="M "
MODIFIED_MODIFIED="MM"
UNSTAGED_DELETED=" D"
STAGED_DELETED="D "
RENAMED="R "
RENAMED_MODIFIED="RM"

Describe "list_dirty_files"
  git() {
    case "$*" in
      "status --porcelain"*)
        echo "$GIT_STATUS_PORCELAIN"
        ;;

      *)
        "$@"
        ;;
  esac
}

  GIT_STATUS_PORCELAIN=""

  Context "when no dirty files"
    It "should return nothing"
      When run list_dirty_files
      The status should be success
      The output should equal ""
    End
  End

  Context "when one file was created but not staged for commit"
    GIT_STATUS_PORCELAIN="$UNTRACKED $SOME_FILE"
    It "should not return file"
      When run list_dirty_files
      The status should be success
      The output should not include "$SOME_FILE"
    End
  End

  Context "when one file was created and staged for commit"
    GIT_STATUS_PORCELAIN="$ADDED $SOME_FILE"
    It "should return file"
      When run list_dirty_files
      The status should be success
      The output should include "$SOME_FILE"
    End

    Context "when staged file was modified but changes were not yet staged for commit"
      GIT_STATUS_PORCELAIN="$ADDED_MODIFIED $SOME_FILE"
      It "should return file"
        When run list_dirty_files
        The status should be success
        The output should include "$SOME_FILE"
      End
    End
  End

  Context "when one existing file was modified but not staged for commit"
    GIT_STATUS_PORCELAIN="$UNSTAGED_MODIFIED $SOME_FILE"
    It "should return file"
      When run list_dirty_files
      The status should be success
      The output should include "$SOME_FILE"
    End
  End

  Context "when one existing file was modified and staged for commit"
    GIT_STATUS_PORCELAIN="$STAGED_MODIFIED $SOME_FILE"
    It "should return file"
      When run list_dirty_files
      The status should be success
      The output should include "$SOME_FILE"
    End

    Context "when staged file was modified but changes were not yet staged for commit"
      GIT_STATUS_PORCELAIN="$MODIFIED_MODIFIED $SOME_FILE"
      It "should return file"
        When run list_dirty_files
        The status should be success
        The output should include "$SOME_FILE"
      End
    End
  End

  Context "when one existing file was deleted but not staged for commit"
    GIT_STATUS_PORCELAIN="$UNSTAGED_DELETED $SOME_FILE"
    It "should not return file"
      When run list_dirty_files
      The status should be success
      The output should not include "$SOME_FILE"
    End
  End

  Context "when one existing file was deleted and staged for commit"
    GIT_STATUS_PORCELAIN="$STAGED_DELETED $SOME_FILE"
    It "should not return file"
      When run list_dirty_files
      The status should be success
      The output should not include "$SOME_FILE"
    End
  End

  Context "when one existing file was renamed but not staged for commit"
    GIT_STATUS_PORCELAIN="$(
      echo "$UNSTAGED_DELETED $SOME_FILE"
      echo "$UNTRACKED $SOME_RENAMED_FILE"
)"

    It "should return not file"
      When run list_dirty_files
      The status should be success
      The output should not include "$SOME_FILE"
      The output should not include "$SOME_RENAMED_FILE"
    End
  End

  Context "when one existing file was renamed and staged for commit"
    GIT_STATUS_PORCELAIN="$RENAMED $SOME_FILE -> $SOME_RENAMED_FILE"
    It "should return renamed file"
      When run list_dirty_files
      The status should be success
      The output should not include "$SOME_FILE"
      The output should include "$SOME_RENAMED_FILE"
    End

    Context "when staged file was modified but changes were not yet staged for commit"
      GIT_STATUS_PORCELAIN="$RENAMED_MODIFIED $SOME_FILE -> $SOME_RENAMED_FILE"
      It "should return file"
        When run list_dirty_files
        The status should be success
        The output should not include "$SOME_FILE"
        The output should include "$SOME_RENAMED_FILE"
      End
    End
  End

  Context "when multiple files with multiple statuses"
    GIT_STATUS_PORCELAIN="$(
      echo "$ADDED ${SOME_FILE}_1"
      echo "$ADDED ${SOME_FILE}_2"
      echo "$RENAMED ${SOME_FILE}_3 -> ${SOME_RENAMED_FILE}_3"
      echo "$UNSTAGED_DELETED ${SOME_FILE}_4"
      echo "$UNTRACKED ${SOME_FILE}_5"
      echo "$RENAMED_MODIFIED ${SOME_FILE}_6 -> ${SOME_RENAMED_FILE}_6"
)"

    It "should return only expected files"
      When run list_dirty_files
      The status should be success
      The output should include "${SOME_FILE}_1"
      The output should include "${SOME_FILE}_2"
      The output should include "${SOME_RENAMED_FILE}_3"
      The output should not include "${SOME_FILE}_4"
      The output should not include "${SOME_FILE}_5"
      The output should include "${SOME_RENAMED_FILE}_6"
    End
  End
End
