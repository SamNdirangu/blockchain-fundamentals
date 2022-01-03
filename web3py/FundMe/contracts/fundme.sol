// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.6;
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract GoFundMe {
    //A public mapping to map the relation between sender address and the amoont
    mapping(address => uint256) public addressToAmountDonated;
    address[] public donors; //Array to store the addresses of owners
    address public owner;

    constructor() public {
        //initialize our owner address when contract is created
        owner = msg.sender;
    }

    //Get the ETH USD conversion rate via oracles via chainlink data feeds
    function getConversionRate() public view returns (uint256) {
        //pass address of the eth usd data feed for the rinkeby test network
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        );
        //Remove variables we don't need that are returned by latestRoundData function and leaving the commas
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        uint8 decimals = priceFeed.decimals();
        //Return our current rate of 1 eth in USD.
        return (uint256(answer) / (10**uint256(decimals)));
    }

    //Functions takes an input of eth in wei and returns the corresponding amount in USD
    function getEthInUSD(uint256 ethWeiAmount) public view returns (uint256) {
        uint256 ethUSDRate = getConversionRate();
        // We divide by 10 to power of 18 because the USD rate is given in wei
        uint256 ethAmountUSD = (ethUSDRate * ethWeiAmount) / (10 * 18);
        return ethAmountUSD;
    }

    //A payable function to handle deposit of funds to our contract
    function donate() public payable {
        //Set the minimum amount in usd our contract will accept
        uint256 minimumUSD = 50;
        require(
            //Get the amount entered in USD
            getEthInUSD(msg.value) >= minimumUSD,
            "Please enter more ether"
        );
        //Update our mappings
        addressToAmountDonated[msg.sender] += msg.value;
        donors.push(msg.sender);
    }

    //Modifier middleware for acertaining user is owner of contract
    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "You are forbidden from withdrawing from this contract"
        );
        _;
    }

    //Functions to handle withdrawals from smart contract
    function withdraw() public payable onlyOwner {
        //in order to withdraw confirm you are owner
        msg.sender.transfer(address(this).balance);
        //reset deposits details after withdrawals.
        for (uint256 donorIndex = 0; donorIndex < donors.length; donorIndex++) {
            address depositor = donors[donorIndex];
            addressToAmountDonated[depositor] = 0;
        }
        donors = new address[](0);
    }
}
