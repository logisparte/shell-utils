#!/bin/sh

Include "$PWD/src/get_absolute_directory_path.sh"

TEST_DATA_DIRECTORY="$PWD/tests/data/get_absolute_directory_path_test"

SOME_FILE="$TEST_DATA_DIRECTORY/some_file"

Describe "get_absolute_directory_path"
  before_all() {
    mkdir -p "$TEST_DATA_DIRECTORY"
    touch "$SOME_FILE"
}

  after_all() {
    rm -rf "$TEST_DATA_DIRECTORY"
}

  BeforeAll "before_all"
  AfterAll "after_all"

  It "should return the absolute path to the file's directory"
    When run get_absolute_directory_path "$SOME_FILE"
    The output should equal "$TEST_DATA_DIRECTORY"
  End
End
