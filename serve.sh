#!/usr/bin/env bash
echo 'http://localhost:8000'
python -m http.server -d docs/ &>/dev/null &
trap 'kill $(jobs -p)' EXIT
find content -type f | entr bash build.sh
