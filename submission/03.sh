# Which tx in block 216,351 spends the coinbase output of block 216,128?
block_hash_216128=$(bitcoin-cli -signet getblockhash 216128)

coinbase_tx_216128=$(bitcoin-cli -signet getblock $block_hash_216128 | jq -r '.tx[0]')

block_hash_216351=$(bitcoin-cli -signet getblockhash 216351)

txs_216351=$(bitcoin-cli -signet getblock $block_hash_216351 | jq -r '.tx[]')

for tx in $txs_216351; do
    raw_tx=$(bitcoin-cli -signet getrawtransaction $tx 1)
    
    spent_coinbase_tx=$(echo "$raw_tx" | jq -r --arg coinbase_tx "$coinbase_tx_216128" '.vin[] | select(.txid == $coinbase_tx) | "true"')

    if [ ! -z "$spent_coinbase_tx" ]; then 
        echo $tx
        exit 0
    fi
done
