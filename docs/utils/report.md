# report

Prints a message in the terminal, optionally in color

## Usage

```text
report [KIND] MESSAGE

MESSAGE: The message to report

KIND: Can be one of:
  --success: Will output the message in lime green

  --info: Will output the message in aqua blue

  --warning: Will output the message in yellow

  --error: Will output the message in red and send it to STDERR

```

## Examples

Use directly:

```shell
report "A message for the queen"
```

```shell
report --info "This is Sparta"
```

```shell
report --success "A tale of victory"
```

```shell
report --warning "Choose your next words carefully Leonidas"
```

```shell
report --error "The persians have found the goat path in the mountains!"
```

or with [colorize](/docs/utils/colorize.md), to partially colorize a message:

```shell
# Pointing to his men
report "$(colorize --bold-white "These") are Sparta's walls."
```
