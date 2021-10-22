#!/usr/bin/env nix-shell
#!nix-shell -p coreutils gnused nixUnstable nixpkgs-fmt -i bash

set -euo pipefail

readonly file="${1:-bin-names.nix}"

nix --experimental-features 'nix-command flakes' build .
{
    echo "# Generated by $(basename $0) script"
    echo "["
    echo 'result/bin/'* | sed 's|result/bin/||g' | sed 's|[^ ][^ ]*|"&"|g' | sort -u
    echo "]"
} > "$file"
nixpkgs-fmt "$file"
