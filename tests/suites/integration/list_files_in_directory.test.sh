#!/bin/sh

Include "$PWD/src/list_files_in_directory.sh"

TEST_DATA_DIRECTORY="$PWD/tests/data/list_files_in_directory_test"

SOME_FILE_1_NAME="some_file_1.txt"
SOME_FILE_2_NAME="some_file_2.txt"
SOME_FILE_1="$TEST_DATA_DIRECTORY/$SOME_FILE_1_NAME"
SOME_FILE_2="$TEST_DATA_DIRECTORY/$SOME_FILE_2_NAME"

Describe "list_files_in_directory"
  before_all() {
    mkdir -p "$TEST_DATA_DIRECTORY"
}

  after_all() {
    rm -rf "$TEST_DATA_DIRECTORY"
}

  BeforeAll "before_all"
  AfterAll "after_all"

  Context "when directory is empty"
    It "should return nothing"
      When run list_files_in_directory "$TEST_DATA_DIRECTORY"
      The status should be success
      The output should equal ""
    End
  End

  Context "when directory has some files"
    It "should return thoses files path"
      touch "$SOME_FILE_1"
      touch "$SOME_FILE_2"
      When run list_files_in_directory "$TEST_DATA_DIRECTORY"
      The status should be success
      The output should include "$SOME_FILE_1_NAME"
      The output should include "$SOME_FILE_2_NAME"
    End
  End
End
