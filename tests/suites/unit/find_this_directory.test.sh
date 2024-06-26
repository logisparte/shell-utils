#!/bin/sh

Include "$PWD/src/find_this_directory.sh"

Describe "find_this_directory"
  _is_symbolic_link() {
    FILE_PATH="$1"

    case "$FILE_PATH" in
      "$FILE_PATH_1")
        "$IS_FILE_1_SYMBOLIC_LINK"
        ;;

      "$FILE_PATH_2")
        "$IS_FILE_2_SYMBOLIC_LINK"
        ;;

      *)
        false
        ;;
  esac
}

  get_absolute_directory_path() {
    FILE_PATH="$1"

    case "$FILE_PATH" in
      "$FILE_PATH_1")
        printf "%s" "$DIRECTORY_1"
        ;;

      "$FILE_PATH_2")
        printf "%s" "$DIRECTORY_2"
        ;;

      "$FILE_PATH_3")
        printf "%s" "$DIRECTORY_3"
        ;;

      *)
        printf "%s" "$FILE_PATH"
        ;;
  esac
}

  _readlink() {
    FILE_PATH="$1"

    case "$FILE_PATH" in
      "$FILE_PATH_1")
        printf "%s" "$FILE_PATH_2"
        ;;

      "$FILE_PATH_2")
        printf "%s" "$FILE_PATH_3"
        ;;

      *)
        printf "%s" "$FILE_PATH"
        ;;
  esac
}

  _get_initial_executable_file_path() {
    echo "$FILE_PATH_1"
}

  DIRECTORY_1="some_directory_1"
  DIRECTORY_2="some_directory_2"
  DIRECTORY_3="some_directory_3"

  FILE_PATH_1="$DIRECTORY_1/some_file"
  FILE_PATH_2="$DIRECTORY_2/some_file"
  FILE_PATH_3="$DIRECTORY_3/some_file"

  IS_FILE_1_SYMBOLIC_LINK=false
  IS_FILE_2_SYMBOLIC_LINK=false

  Context "when executable path is not a symbolic link"
    It "should return the executable path directory"
      When run find_this_directory
      The status should be success
      The output should equal "$DIRECTORY_1"
    End
  End

  Context "when executable path is a symbolic link"
    IS_FILE_1_SYMBOLIC_LINK=true
    It "should return the linked executable path directory"
      When run find_this_directory
      The status should be success
      The output should equal "$DIRECTORY_2"
    End
  End

  Context "when executable path is a symbolic link that links to another symbolic link"
    IS_FILE_1_SYMBOLIC_LINK=true
    IS_FILE_2_SYMBOLIC_LINK=true
    It "should return the deep linked executable path directory"
      When run find_this_directory
      The status should be success
      The output should equal "$DIRECTORY_3"
    End
  End
End
