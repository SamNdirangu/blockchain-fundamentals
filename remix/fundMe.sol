// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.6 <0.9.0;
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    //A public mapping to store the relation between our sender address and the amount in gwei deposited to our contract
    mapping(address => uint256) public addressToAmountDeposited;
    address[] public depositors;
    address public owner;
    constructor() public {
        //initialize the contract with the owner's address
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
        uint256 ethPrice = getConversionRate();
        uint256 ethAmountInUSD = (ethPrice * ethWeiAmount) / (10**18);
        return ethAmountInUSD;
    }

     //Function to handle deposit of funds to our contract
    function deposit() public payable {
        //Minimum amount in USD our contract can accept
        uint256 minimumUSD = 50;
        require(
            //Get the amount entered in USD
            getEthInUSD(msg.value) >= minimumUSD,
            "Please enter more ether, the amount entered is below the min limit"
        );
        addressToAmountDeposited[msg.sender] += msg.value;
        depositors.push(msg.sender);
    }

    //Modifier middleware for acertaining user is owner of contract
    modifier onlyOwner {
        require(msg.sender == owner, "You are forbidden from withdrawing from this contract");
        _;
    } 
    //Functions to handle withdrawals from smart contract
    function withdraw() payable onlyOwner public  {
        //in order to withdraw confirm you are owner
        msg.sender.transfer(address(this).balance);
        //reset deposits details after withdrawals.
        for(uint256 depositorIndex=0; depositorIndex < depositors.length; depositorIndex++){
            address depositor = depositors[depositorIndex];
            addressToAmountDeposited[depositor] = 0;
        }
        depositors = new address[](0);
    }
}
