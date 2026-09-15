#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
nix flake check --no-build
nix build .#darwinConfigurations.Daniels-MacBook-Pro.system
nix fmt -- --ci
