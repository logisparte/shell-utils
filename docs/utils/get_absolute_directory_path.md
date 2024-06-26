# get_absolute_directory_path

Find the absolute path to the directory containing the file located at the provided relative
path

## Usage

```text
get_absolute_directory_path RELATIVE_FILE_PATH

RELATIVE_FILE_PATH: The relative path to the file
```

## Examples

With a file located at `./tactics/combat/form_phalanx.sh`:

```shell
# ./tactics/stealth/prepare_ambush.sh

COMBAT_DIRECTORY_ABSOLUTE_PATH="$(get_absolute_directory_path "../combat/form_phalanx.sh")"
```

To have `$COMBAT_DIRECTORY_ABSOLUTE_PATH` equal to `$PWD/tactics/combat`
