#!/bin/bash
# Usage: yk-decrypt <input.enc> <output.tar.gz>
set -e
IN="$1"
OUT="$2"
LIBP11_PATH="/opt/homebrew/Cellar/libp11/0.4.20/lib/ossl-modules"

if [ -z "$IN" ] || [ -z "$OUT" ]; then
  echo "Usage: yk-decrypt <input.enc> <output.tar.gz>"
  exit 1
fi

read -sp "Enter PIV PIN: " PIN
echo

openssl cms -decrypt -provider-path "$LIBP11_PATH" -provider pkcs11prov -provider default \
  -inkey "pkcs11:id=%03;type=private?pin-value=${PIN}" \
  -in "$IN" -inform DER -binary -out "$OUT"
echo "Decrypted to $OUT"
