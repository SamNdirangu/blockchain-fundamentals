from brownie import SimpleStorage, accounts, config # type: ignore


def readContract():
    # -1 will access us to the newest entry to the array ie the latest uploaded contract4
    simple_storage = SimpleStorage[-1]
    # Read our current stored random number
    print(simple_storage.getRandomNumber())


def main():
    readContract()