// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uin256;

    uint256 public minimumUsd = 50 * 1e18;
    address[] public funders;
    mapping(address => uint256) addrTofund;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable {
        require(
            msg.value.getConversionRate() >= minimumUsd,
            "Minimum usd is 50"
        );
        funders.push(msg.sender);
        addrTofund[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner {
        for (uint256 funderIdx = 0; funderIdx < funders.length; funderIdx++) {
            address funder = funders[funderIdx];
            addrTofund[funder] = 0;
        }
        // reset the funders
        funders = new address[](0);

        // one of below can be used to transfer the fund back
        // transfer
        // payable(msg.sender).transfer(address(this).balance);
        // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed!");
        // call - recommended way
        (bool callSuccess, ) = payable(msg.sender).call(address(this).balance);
        require(callSuccess, "Call failed!");
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can withdraw fund!!");
        _;
    }
}
