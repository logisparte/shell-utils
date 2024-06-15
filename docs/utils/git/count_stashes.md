# git: count_stashes

Outputs the number of stashes

## Usage

```shell
count_stashes
```

## Example

Use in numeric comparisons:

```shell
if [ "$(count_stashes)" -gt 0 ]; then
  # Supplies have been set aside for later. Quartermaster, make sure we don't lose any
fi
```
