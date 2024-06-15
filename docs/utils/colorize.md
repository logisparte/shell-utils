# colorize

Colorize text to be displayed in the terminal

## Usage

```text
colorize [COLOR_OPTION] TEXT

TEXT: The text to colorize

COLOR_OPTION: Can be one of:
  --black
  --maroon
  --green
  --olive
  --navy
  --purple
  --teal
  --silver
  --gray
  --red
  --lime
  --yellow
  --blue
  --fuchsia
  --aqua
  --white
  --bold-white

  or

  --xterm [COLOR_CODE]

  where COLOR_CODE is a number between 0 and 255 matching an xterm color code
```

> If `NO_COLOR=1` is set in the environment, no color will be applied

## Examples

Use with `printf`:

```shell
printf "Brasidas was a %s spartan hero" "$(colorize --bold-white "real")"
```

or [report](/docs/utils/report.md):

```shell
report "Brasidas was a $(colorize --bold-white "real") spartan hero"
```
