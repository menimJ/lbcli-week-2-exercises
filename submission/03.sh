#!/usr/bin/env bash
# Create a SegWit address.
# Add funds to the address.
# Return only the Address

set -euo pipefail

BITCOIN_ARGS=()
if [[ -n "${BITCOIN_DATADIR:-}" ]]; then
  BITCOIN_ARGS+=(-datadir="$BITCOIN_DATADIR")
fi

bitcoin-cli() {
  command bitcoin-cli "${BITCOIN_ARGS[@]}" "$@"
}

if ! bitcoin-cli -regtest listwallets | grep -q '"btrustwallet"'; then
  bitcoin-cli -regtest loadwallet "btrustwallet" >/dev/null 2>&1 || bitcoin-cli -regtest createwallet "btrustwallet" >/dev/null
fi

ADDRESS=$(bitcoin-cli -regtest -rpcwallet=btrustwallet getnewaddress "" bech32)
bitcoin-cli -regtest generatetoaddress 101 "$ADDRESS" >/dev/null
echo "$ADDRESS"

