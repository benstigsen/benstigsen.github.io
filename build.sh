#!/usr/bin/env bash

set -euo pipefail

TEMPLATE="template.html"
CONTENT_DIR="content"
OUTPUT_DIR="docs"

# Recreate output directory
rm -rf "$OUTPUT_DIR"
cp -r "$CONTENT_DIR" "$OUTPUT_DIR"

template=$(<"$TEMPLATE")

find "$OUTPUT_DIR" -type f -name "*.html" | while read -r file; do
    title=$(sed -n 's:.*<h2>\(.*\)</h2>.*:\1:p' "$file" | head -n1)
    content=$(<"$file")

    output="${template//\{\{ title \}\}/$title}"
    output="${output//\{\{ content \}\}/$content}"

    printf '%s' "$output" > "$file"
done

date +%s%N > "$OUTPUT_DIR/.reload"
