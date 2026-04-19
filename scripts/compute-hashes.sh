#!/usr/bin/env bash
# Computes SHA-256 and byte size for each model file in the given directory.
# Output is formatted so you can paste the numbers straight into manifest.json.
#
# Usage: scripts/compute-hashes.sh [dir]
#   dir: directory containing the exported ONNX files (default: current dir)

set -euo pipefail

dir="${1:-.}"
if [[ ! -d "$dir" ]]; then
  echo "error: '$dir' is not a directory" >&2
  exit 1
fi

cd "$dir"

# Files the library expects; order matches manifest.json for easy paste-across.
files=(
  toxicity.onnx
  embedding.onnx
  vocab.txt
  anchors.bin
  prompt_injection.onnx
  pii_ner.onnx
)

found_any=0
missing=()

for f in "${files[@]}"; do
  if [[ -f "$f" ]]; then
    found_any=1
    # stat -c is GNU; stat -f is BSD/macOS. Try both.
    size=$(stat -c%s "$f" 2>/dev/null || stat -f%z "$f")
    sha=$(sha256sum "$f" | awk '{print $1}')
    printf '%-24s  sha256=%s  size=%d\n' "$f" "$sha" "$size"
  else
    missing+=("$f")
  fi
done

if [[ "$found_any" -eq 0 ]]; then
  echo "error: no model files found in '$dir'. expected one or more of:" >&2
  printf '  - %s\n' "${files[@]}" >&2
  exit 1
fi

if [[ "${#missing[@]}" -gt 0 ]]; then
  echo >&2
  echo "note: skipped (not present in '$dir'):" >&2
  printf '  - %s\n' "${missing[@]}" >&2
fi
