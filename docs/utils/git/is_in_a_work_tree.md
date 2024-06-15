# git: is_in_a_work_tree

Returns wether the current directory is in a `git` repository

## Usage

```shell
is_in_a_work_tree
```

## Example

Use in boolean comparisons:

```shell
if ! is_in_a_work_tree; then
  # Not in an enemy territory, send an embassy to the local authorities before proceeding

else
  # March on
fi
```
