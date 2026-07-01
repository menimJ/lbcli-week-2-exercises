#!/usr/bin/env bash
# List the current UTXOs in your wallet.

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

bitcoin-cli -regtest -rpcwallet=btrustwallet listunspent
