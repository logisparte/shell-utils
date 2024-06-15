# shell-utils

Collection of POSIX-compatible shell functions to simplify writing scripts

## License

This repository is distributed under the terms of the [Apache 2.0 license](/LICENSE)

## Contributors

### Docker

A development Docker image is used to encapsulate project dependencies and runtime environment.
To build the image:

```shell
./docker/env.sh init
```

To start a development container:

```shell
./docker/env.sh up
```

To open a shell inside the development container

```shell
./docker/env.sh shell
```

To stop the development container:

```shell
./docker/env.sh down
```

### Format

[shfmt](https://github.com/mvdan/sh) is used to format shell files.
[Prettier](https://github.com/prettier/prettier) is used to format markdown and yaml files. To
format dirty files:

```shell
./scripts/format.sh
```

To format all files:

```shell
./scripts/format.sh all
```

### Lint

[ShellCheck](https://github.com/koalaman/shellcheck) is used to analyze shell code.
[MarkdownLint](https://github.com/igorshubovych/markdownlint-cli) is used to analyze markdown
code. To analyze dirty files:

```shell
./scripts/lint.sh
```

To analyze all files:

```shell
./scripts/lint.sh all
```

### Test

[ShellSpec](https://github.com/shellspec/shellspec) is used to test the source code. To run all
tests:

```shell
./scripts/test.sh
```

To run a specific test suite:

```shell
./scripts/test.sh SUITE
```

### Coverage

[Kcov](https://github.com/SimonKagstrom/kcov) is used to measure test coverage during tests. To
view the coverage report after a test run:

```shell
./scripts/coverage.sh
```

> NOTE: Multiline strings may report as non-covered due this
> [issue](https://github.com/SimonKagstrom/kcov/issues/145)
