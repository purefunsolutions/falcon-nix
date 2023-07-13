#!/usr/bin/env bash
set -xeuo pipefail

nix fmt *
nix-shell -p python3Packages.black --run "black falcon ."
