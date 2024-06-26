# shell-utils

Collection of POSIX-compatible shell utility functions to simplify script writing

## License

This repository is distributed under the terms of the [Apache 2.0 license](/LICENSE)

## Users

### Usage

- Copy/paste any file in `/src` into your project's `/scripts/utils` directory. Make sure to
  preserve its relative path and to also copy over its dependencies (sourced utility files at
  the top) if applicable.
- Source the file from any shell script in your project, example: `. ./scripts/utils/report.sh`
- Use the sourced function locally

### Documentation

Each utility has a documentation page [here](/docs/utils).

## Contributors

First, clone the repository and configure the git hooks:

```shell
git clone git@github.com:logisparte/shell-utils.git
cd shell-utils
git config --local core.hooksPath "$PWD/hooks"
```

### docker-env

This repository uses [docker-env](https://github.com/logisparte/docker-env) to encapsulate its
development environment inside a Docker container.

To build the docker dev image:

```shell
./docker/env.sh init
```

To start a development container:

```shell
./docker/env.sh up
```

To execute a command inside the development container:

```shell
./docker/env.sh exec COMMAND
```

To open a shell inside the development container

```shell
./docker/env.sh shell
```

To stop the development container:

```shell
./docker/env.sh down
```

> For more information about `docker-env`, use `./docker/env.sh --help` and read the
> [documentation](https://github.com/logisparte/docker-env/tree/master/docs)

### Scripts

#### Format

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

#### Lint

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

#### Test

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
