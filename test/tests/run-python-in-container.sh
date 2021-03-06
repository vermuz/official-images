#!/bin/bash
set -e

testDir="$(readlink -f "$(dirname "$BASH_SOURCE")")"
runDir="$(dirname "$(readlink -f "$BASH_SOURCE")")"

source "$runDir/run-in-container.sh" "$testDir" "$1" sh -ec '
	for c in pypy3 pypy python3 python; do
		if PATH=/usr/local/bin command -v "$c" > /dev/null; then
			exec "$c" "$@"
		fi
	done
	echo >&2 "error: unable to determine how to run python"
	exit 1
' -- ./container.py
