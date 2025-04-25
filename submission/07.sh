# what is the coinbase tx in this block 243,834
block_hash=$(bitcoin-cli -signet getblockhash 243834)
coinbase_tx=$(bitcoin-cli -signet getblock $block_hash | jq -r '.tx[0]')

echo $coinbase_tx