#!/bin/bash
# Usage: yk-encrypt <input-folder> <output.enc>
set -e
SRC="$1"
OUT="$2"
CERT="$HOME/enc/9d-pub.pem"

if [ -z "$SRC" ] || [ -z "$OUT" ]; then
  echo "Usage: yk-encrypt <input-folder> <output.enc>"
  exit 1
fi

tar czf - "$SRC" | openssl cms -encrypt -recip "$CERT" -aes256 -binary -outform DER -keyopt rsa_padding_mode:oaep -out "$OUT"
echo "Encrypted to $OUT"
