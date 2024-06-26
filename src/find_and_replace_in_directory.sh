#!/bin/sh
#
# Copyright 2024 logisparte inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

find_and_replace_in_directory() {
  DIRECTORY="$1"
  ORIGINAL_STRING="$2"
  REPLACEMENT_STRING="$3"

  find "$DIRECTORY" -type f -exec sh -c \
    'FILE="$1";
    SUBSTITUTION="$2";
    LANG=C sed "$SUBSTITUTION" "$FILE" > "$FILE.replacing";
    mv "$FILE.replacing" "$FILE"' _ {} "s/$ORIGINAL_STRING/$REPLACEMENT_STRING/g" \;
}
