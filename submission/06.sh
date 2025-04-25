# Only one tx in block 243,821 signals opt-in RBF. What is its txid?
block_hash=$(bitcoin-cli -signet getblockhash 243821)

block=$(bitcoin-cli -signet getblock $block_hash 2)

txid=$(echo $block | jq -r '.tx[] | select(.vin[].sequence <= 4294967293) | .txid')

echo $txid