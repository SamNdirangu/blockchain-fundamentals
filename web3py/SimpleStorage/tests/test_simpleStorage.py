from brownie import SimpleStorage, config, accounts # type: ignore

def test_initialValue():
    #Arrange
    account = accounts.add(config["wallets"]["from_key"])
    #Act
    simple_storage = SimpleStorage.deploy({"from": account})
    initialValue = simple_storage.getRandomNumber()
    expectedValue = 45 
    #Assert
    assert initialValue == expectedValue
    
def test_updateValue():
    #Arrange
    account = accounts.add(config["wallets"]["from_key"])
    #Act
    simple_storage = SimpleStorage.deploy({"from": account})
    expectedValue = 45 
    simple_storage.updateRandomNumber(expectedValue, {"from": account})
    #Assert
    assert expectedValue == simple_storage.getRandomNumber()
    
