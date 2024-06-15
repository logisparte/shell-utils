# git: count_commits_ahead

Outputs the number of local unpushed commits

## Usage

```shell
count_commits_ahead
```

## Example

Use in numeric comparisons:

```shell
if [ "$(count_commits_ahead)" -gt 0 ]; then
  # Push the frontline forward
fi
```
