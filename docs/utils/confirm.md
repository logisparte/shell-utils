# confirm

Ask the user a close-ended question to determine the flow of execution

## Usage

```text
confirm [NON_INTERACTIVE_OPTION] [QUESTION]

QUESTION: The close-ended question to ask the user (default: "Are you sure?")
NON_INTERACTIVE_OPTIONS:
  --yes: Default to true in non-interactive environments
  --no: Default to false in non-interactive environments
```

## Examples

Use with an `if` statement:

```shell
if confirm "Send 300 men to Thermopylae?"; then
  # March.
else
  # Let's just send some earth and water...
fi
```

Add `--yes` or `--no` option to add a default answer for non-interactive environments:

```shell
if confirm --yes "Send 300 men to Thermopylae?"; then
  # March.
else
  # <Execution will never go through here in non-interactive environments>
fi
```
