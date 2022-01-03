from brownie import accounts, config, network # type: ignore

def getAccount():
    if network.show_active() == 'development':
        return accounts[0] # dummy account spinned up by ganache cli 
    else:
        #Return our live actual account stored in the env
        return accounts.add(config["wallets"]["from_key"])