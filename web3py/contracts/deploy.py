# Do our imports
import json
from solcx import compile_standard, install_solc
install_solc("0.6.0")

with open("./simpleStorage.sol", "r") as file:
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
with open("compiled_sol.json", "w") as file:
    json.dump(compiled_sol, file)

# get bytecode
bytecode = compiled_sol["contracts"]["simpleStorage.sol"]["SimpleStorage"]["evm"]["bytecode"]["object"]

# get abi
abi = compiled_sol["contracts"]["simpleStorage.sol"]["SimpleStorage"]["abi"]
