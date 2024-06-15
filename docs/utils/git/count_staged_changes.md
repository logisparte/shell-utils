# git: count_staged_changes

Outputs the number of local changes staged for commit

## Usage

```shell
count_staged_changes
```

## Example

Use in numeric comparisons:

```shell
if [ "$(count_staged_changes)" -eq 0 ]; then
  # No troops have mustered yet, we cannot march
fi
```
