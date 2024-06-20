#!/bin/sh -e

PROJECT_NAME="$(basename "$PWD")"
DOCKER_DIRECTORY="$PWD/docker"
COMPOSE_FILE="$DOCKER_DIRECTORY/compose.yaml"
DOCKER_HOST_DIRECTORY="$DOCKER_DIRECTORY/host"
COMPOSE_ENV_FILE="$DOCKER_HOST_DIRECTORY/.env"
PASSWD_FILE="$DOCKER_HOST_DIRECTORY/passwd"
GROUP_FILE="$DOCKER_HOST_DIRECTORY/group"
SUDOER_FILE="$DOCKER_HOST_DIRECTORY/sudoer"
HELP="Available commands
------------------------------------------------------------------
init  | Prepare host files and build dev env image
up    | Create and start a persistent dev env container
down  | Stop and remove the dev env container
exec  | Execute a command in the running dev env container
shell | Open an interactive shell in the running dev env container"

env() {
  COMMAND="${1:-help}"

  if [ -n "$DEV_ENV_CURRENT" ]; then
    if [ "$COMMAND" = "_entrypoint" ]; then
      shift
      _entrypoint "$@"
      return

    else
      echo "[docker] Already inside the dev env container." >&2
      exit 1
    fi
  fi

  echo "[docker:$COMMAND]" && echo
  case "$COMMAND" in
    help)
      echo "$HELP"
      ;;

    init)
      _init
      _compose pull --ignore-buildable
      _compose build
      ;;

    up)
      _compose up --wait
      ;;

    down)
      _compose down
      ;;

    exec)
      shift
      _compose exec dev-env "$@"
      ;;

    shell)
      _compose exec dev-env "${SHELL:-/bin/sh}" --login
      ;;

    *)
      echo \
        "[docker] Unknown command: '$COMMAND'." \
        "Use the 'help' command to see available commands." >&2
      exit 1
      ;;
  esac

  echo && echo "[docker:$COMMAND] Done"
}

_compose() {
  if [ -n "$DEV_ENV_USER_COMPOSE_FILE" ] && [ -f "$DEV_ENV_USER_COMPOSE_FILE" ]; then
    set -- --file "$DEV_ENV_USER_COMPOSE_FILE" "$@"
  fi

  docker compose \
    --project-name "$PROJECT_NAME" \
    --env-file "$COMPOSE_ENV_FILE" \
    --file "$COMPOSE_FILE" \
      "$@"
}

_init() {
  echo "[docker:init] Preparing docker host files"
  rm -rf "$DOCKER_HOST_DIRECTORY"
  mkdir -p "$DOCKER_HOST_DIRECTORY"

  # User ID
  HOST_USERNAME="$(id -un)"
  HOST_UID="$(id -u)"
  HOST_GID="$(id -g)"

  # SSH socket
  if [ "$(uname)" = "Darwin" ]; then
    HOST_SSH_AUTH_SOCK="/run/host-services/ssh-auth.sock" # Docker for Mac workaround

  else
    HOST_SSH_AUTH_SOCK="$SSH_AUTH_SOCK"
  fi

  # /etc/passwd file
  {
    echo "root:x:0:0:root:/root:/bin/sh"
    if [ "$HOST_UID" != "0" ]; then
      echo "$HOST_USERNAME::$HOST_UID:$HOST_GID:$HOST_USERNAME:$HOME:${SHELL:-/bin/sh}"
    fi
  } > "$PASSWD_FILE"

  # /etc/group file
  echo "$HOST_USERNAME:x:$HOST_GID:" > "$GROUP_FILE"

  # /etc/sudoers.d/$HOST_USERNAME file
  if ! sudo -n true 2> /dev/null; then
    echo "[docker:init] This script will generate a 'sudoers.d' file to be mounted in the" \
      "development container. As this file needs to be owned by the root user, your password" \
      "will be required."
  fi

  echo "$HOST_USERNAME ALL=(ALL) NOPASSWD:ALL" > "$SUDOER_FILE"
  chmod 440 "$SUDOER_FILE"
  sudo chown root "$SUDOER_FILE"

  # docker compose env file
  {
    echo "PROJECT_NAME=$PROJECT_NAME"
    echo "HOST_USERNAME=$HOST_USERNAME"
    echo "HOST_UID=$HOST_UID"
    echo "HOST_GID=$HOST_GID"
    echo "HOST_SSH_AUTH_SOCK=$HOST_SSH_AUTH_SOCK"
  } > "$COMPOSE_ENV_FILE"
}

_entrypoint() {
  USERNAME="$(id -un)"

  # Rationalize ownership of project's ancestor directories
  PARENT_DIRECTORY="$(dirname "$PWD")"
  while [ "$PARENT_DIRECTORY" != "/" ]; do
    sudo chown "$USERNAME" "$PARENT_DIRECTORY"
    if [ "$PARENT_DIRECTORY" = "$HOME" ]; then
      break
    fi

    PARENT_DIRECTORY="$(dirname "$PARENT_DIRECTORY")"
  done

  # Exec provided command or pause to keep container alive
  if [ $# -gt 0 ]; then
    "$@"

  else
    tail -f /dev/null
  fi
}

env "$@"
