#!/bin/sh

Include "$PWD/src/find_and_replace_in_directory.sh"

TEST_DATA_DIRECTORY="$PWD/tests/data/find_and_replace_in_directory_test"

SOME_DIRECTORY_1="$TEST_DATA_DIRECTORY/some_directory"
SOME_DIRECTORY_2="$TEST_DATA_DIRECTORY/some_directory/some_subdirectory"
SOME_FILE_1="$SOME_DIRECTORY_1/some_file_1"
SOME_FILE_2="$SOME_DIRECTORY_2/some_file_2"

SOME_STRING_TO_REPLACE="Some string to replace"
SOME_REPLACEMENT_STRING="Some replaced string"

SOME_FILE_CONTENT_1="$SOME_STRING_TO_REPLACE 1"
SOME_REPLACED_FILE_CONTENT_1="$SOME_REPLACEMENT_STRING 1"
SOME_FILE_CONTENT_2="$SOME_STRING_TO_REPLACE 2"
SOME_REPLACED_FILE_CONTENT_2="$SOME_REPLACEMENT_STRING 2"

Describe "find_and_replace_in_directory"
  before_all() {
    mkdir -p "$TEST_DATA_DIRECTORY"
    mkdir "$SOME_DIRECTORY_1"
    mkdir "$SOME_DIRECTORY_2"
    echo "$SOME_FILE_CONTENT_1" >> "$SOME_FILE_1"
    echo "$SOME_FILE_CONTENT_2" >> "$SOME_FILE_2"
}

  after_all() {
    rm -rf "$TEST_DATA_DIRECTORY"
}

  BeforeAll "before_all"
  AfterAll "after_all"

  Context "when string to replace is not present in any file"
    It "should not change files"
      When run find_and_replace_in_directory \
        "$TEST_DATA_DIRECTORY" \
        "Some non-present string" \
        "$SOME_REPLACEMENT_STRING"
      The status should be success
      The contents of file "$SOME_FILE_1" should equal "$SOME_FILE_CONTENT_1"
      The contents of file "$SOME_FILE_2" should equal "$SOME_FILE_CONTENT_2"
    End
  End

  Context "when string to replace is present in files"
    It "should replace all occurences with replacement string"
      When run find_and_replace_in_directory \
        "$TEST_DATA_DIRECTORY" \
        "$SOME_STRING_TO_REPLACE" \
        "$SOME_REPLACEMENT_STRING"
      The status should be success
      The contents of file "$SOME_FILE_1" should equal "$SOME_REPLACED_FILE_CONTENT_1"
      The contents of file "$SOME_FILE_2" should equal "$SOME_REPLACED_FILE_CONTENT_2"
    End
  End
End
