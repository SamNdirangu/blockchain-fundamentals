import os
# pylance: disable=reportMissingImports
from brownie import accounts, config, network, SimpleStorage # type: ignore

def deploy_simpleStorage():
    # account = accounts[0] # the account 0 zero created as brownies spins up ganache
    # account = accounts.load('sparrow') loads our created account via cli codenamed sparrow..
    # brownie will however prompt us a password we used when creating the account.
    # account = accounts.add(os.getenv("PRIVATE_KEY")) grab account detail from private key stored in our .env
    # account = accounts.add(config["wallets"]["from_key"]) grab account from our config yaml file - recommended
    # print(account)

    account = getAccount()
    # Brownie will build, sign and send our contract creation transaction for us
    simple_storage = SimpleStorage.deploy({"from": account})
    simple_storage
    #Get our stored randomNumber
    stored_randomNumber = simple_storage.getRandomNumber()
    print('Initial Number: ' + str(stored_randomNumber))
    # Update our random number
    updateNumberTransaction = simple_storage.updateRandomNumber(1995, {"from": account})
    updateNumberTransaction.wait(1)
    print('New Number: ' + str(simple_storage.getRandomNumber()))
    

def getAccount():
    if network.show_active() == 'development':
        return accounts[0] # dummy account spinned up by ganache cli 
    else:
        #Return our live actual account stored in the env
        return accounts.add(config["wallets"]["from_key"])

def main():
    deploy_simpleStorage()