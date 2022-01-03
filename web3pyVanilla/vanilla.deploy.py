# Do our imports
import json
import os
from web3 import Web3
from dotenv import load_dotenv
from solcx import compile_standard, install_solc
# intall our specific solidity compiler version
install_solc("0.6.0")
# Load our dotenv file
load_dotenv()

with open("./contracts/simpleStorage.sol", "r") as file:
    simple_storage_file = file.read()

# compile our imported sol
compiled_sol = compile_standard(
    {
        "language": "Solidity",
        "sources": {
            "simpleStorage.sol": {
                "content": simple_storage_file
            }
        },
        "settings": {
            "outputSelection": {
                "*": {
                    "*": ["abi", "metadata", "evm.bytecode", "evm.sourceMap"]
                }
            }
        }
    },
    solc_version="0.6.0"
)

# Store compiled code into file.
with open("./build/compiled_sol.json", "w") as file:
    json.dump(compiled_sol, file)

# get bytecode
bytecode = compiled_sol["contracts"]["simpleStorage.sol"]["SimpleStorage"]["evm"]["bytecode"]["object"]
# get abi
abi = compiled_sol["contracts"]["simpleStorage.sol"]["SimpleStorage"]["abi"]

# Inititialize our web3 with the url to our blockchain
w3 = Web3(Web3.HTTPProvider(os.getenv("BLOCKCHAIN_URL")))
chain_id = os.getenv("CHAINID")
my_address = os.getenv("MY_ADDRESS")
private_key = os.getenv("PRIVATE_KEY")

# Create the contract in python
SimpleStorage = w3.eth.contract(abi=abi, bytecode=bytecode)
# Get latest transaction
nonce = w3.eth.getTransactionCount(my_address)
print("Current Nonce: " + str(nonce))
# 1 Build a transaction
print("Building  Contract Transaction...")
transaction = SimpleStorage.constructor().buildTransaction({
    "gasPrice": w3.eth.gas_price,
    "from": my_address,
    "nonce": nonce
})
# 2 Sign the transaction
print("Signing Contract Transaction...")
signed_txn = w3.eth.account.sign_transaction(
    transaction, private_key=private_key)

# 3 Send our transaction request to the blockchain
print('Sending Contract Transaction...')
tx_hash = w3.eth.send_raw_transaction(signed_txn.rawTransaction)
print("Waiting for Contract transaction receipt")
tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)
print("Contract address: " + str(tx_receipt.contractAddress))

# Interact with the deployed contract
# Required contract address and contract abi
simple_storage = w3.eth.contract(address=tx_receipt.contractAddress, abi=abi)

print("Current Fav Number: " + str(simple_storage.functions.getFavNumber().call()))
# build transaction
print("Building store transaction...")
store_transaction = simple_storage.functions.storeFavNumber(2077).buildTransaction({
    "gasPrice": w3.eth.gas_price,
    "from": my_address,
    "nonce": nonce + 1
})
# sign transaction
print("Signing store transaction...")
signed_store_txn = w3.eth.account.sign_transaction(
    store_transaction, private_key=private_key)
# send transaction
print("Sending store transaction...")
store_tx_hash = w3.eth.send_raw_transaction(signed_store_txn.rawTransaction)
print('Waiting for receipt...')
store_tx_receipt = w3.eth.wait_for_transaction_receipt(store_tx_hash)
print("Updated FavNumber: " + str(simple_storage.functions.getFavNumber().call()))
