# How many new outputs were created by block 243,825?

block_hash=$(bitcoin-cli -signet getblockhash 243825)

tx_vout_length=$(bitcoin-cli -signet getblock $block_hash 2 | jq -r '[.tx[].vout | length] | add')

echo $tx_vout_length