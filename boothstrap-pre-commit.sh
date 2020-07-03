#!/usr/bin/env bash
# Usage: scripts/autocorrect

set -eu
echo "Configuring pre-commit hook..."
file="../.git/hooks/pre-commit"
path=".git/hooks"
echo $(pwd)
rm -f $file
cp -f pre-commit $file
echo "Done coping pre-hook in $file"
