# git: count_unstaged_changes

Outputs the number of local changes not staged for commit, excluding untracked files

## Usage

```shell
count_unstaged_changes
```

## Example

Use in numeric comparisons:

```shell
if [ "$(count_unstaged_changes)" -eq 0 ]; then
  # All troops have mustered, let's march
fi
```
