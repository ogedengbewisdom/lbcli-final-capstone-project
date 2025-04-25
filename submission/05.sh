# How many satoshis did this transaction pay for fee?: b71fb9ab7707407cc7265591e0c0d47d07afede654f91de1f63c0cb522914bcb
tx=b71fb9ab7707407cc7265591e0c0d47d07afede654f91de1f63c0cb522914bcb
raw_tx=$(bitcoin-cli -signet getrawtransaction $tx true)

inputs=0

length_of_inputs=$(echo "$raw_tx" | jq -r '.vin | length')

for (( i=0; i < $length_of_inputs; i++)); do
    txid=$(echo $raw_tx | jq -r ".vin[$i].txid")
    voutput=$(echo $raw_tx | jq -r ".vin[$i].vout")
    utxos=$(bitcoin-cli -signet getrawtransaction $txid true | jq -r ".vout[$voutput].value")
    inputs=$(echo "$inputs+$utxos" | bc)
done
output=$(echo $raw_tx | jq -r '[.vout[].value] | add')

txfees=$(echo "$inputs-$output" | bc)

echo "$txfees*100000000" | bc | cut -d'.' -f 1