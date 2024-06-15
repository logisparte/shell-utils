# git: count_commits_behind

Outputs the number of remote unpulled commits

## Usage

```shell
count_commits_behind
```

## Example

Use in numeric comparisons:

```shell
if [ "$(count_commits_behind)" -gt 0 ]; then
  # Bring the frontline closer
fi
```
