from brownie import GoFundMe # type: ignore
from scripts.functions.getAccount import getAccount
def deploy_FundMe():
    #Arrange
    account = getAccount()
    fundMe = GoFundMe.deploy({"from": account}, publish_source=True)
    print(f"Contract deployed to : {fundMe.address}")
    



def main():
    deploy_FundMe()