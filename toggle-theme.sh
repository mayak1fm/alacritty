#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ACTIVE="$CONFIG_DIR/theme-current.toml"
DARK="$CONFIG_DIR/themes/catppuccin-mocha.toml"
LIGHT="$CONFIG_DIR/themes/github-light-hc.toml"
MAIN="$CONFIG_DIR/alacritty.toml"

MODE="${1:-toggle}"

if [ ! -e "$ACTIVE" ]; then
  ln -sfn "$DARK" "$ACTIVE"
fi

CURRENT="$(readlink -f "$ACTIVE" || true)"

case "$MODE" in
  dark)
    ln -sfn "$DARK" "$ACTIVE"
    ;;
  light)
    ln -sfn "$LIGHT" "$ACTIVE"
    ;;
  toggle)
    if [ "$CURRENT" = "$LIGHT" ]; then
      ln -sfn "$DARK" "$ACTIVE"
    else
      ln -sfn "$LIGHT" "$ACTIVE"
    fi
    ;;
  *)
    echo "usage: $0 [light|dark|toggle]" >&2
    exit 1
    ;;
esac

touch "$MAIN"
