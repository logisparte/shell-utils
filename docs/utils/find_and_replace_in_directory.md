# find_and_replace_in_directory

Find and replace all occurences of a string in all files in directory and subdirectories

## Usage

```text
find_and_replace_in_directory DIRECTORY ORIGINAL_STRING REPLACEMENT_STRING

DIRECTORY: The directory to search in
ORIGINAL_STRING: The string to find in each files
REPLACEMENT_STRING: The string to replace ORIGINAL_STRING with
```

## Examples

With context:

```shell
# ./diplomacy/list_all_relations.sh

echo "Themistocles is an ally"
```

```shell
# ./diplomacy/athens/list_athenian_relations.sh

echo "Themistocles is an ally"
```

Use directly:

```shell
find_and_replace_in_directory "./diplomacy" "Themistocles is an ally" "Themistocles is an enemy"
```

To result in:

```shell
# ./diplomacy/list_all_relations.sh

echo "Themistocles is an enemy"
```

```shell
# ./diplomacy/athens/list_athenian_relations.sh

echo "Themistocles is an enemy"
```
