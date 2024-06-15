# git: list_all_files

Outputs a list of all files tracked by `git`

## Usage

```shell
list_all_files
```

## Examples

With context:

```shell
scytale_decrypt_all() {
  # decrypt all provided files using a scytale
}
```

Use as a list of argument:

```shell
list_all_files | xargs scytale_decrypt_all
```

Would decrypt all files tracked by `git`
