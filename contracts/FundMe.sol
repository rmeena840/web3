// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uin256;

    uint256 public minimumUsd = 50 * 1e18;
    address[] public funders;
    mapping(address => uint256) addrTofund;

    function fund() public payable {
        require(
            msg.value.getConversionRate() >= minimumUsd,
            "Minimum usd is 50"
        );
        funders.push(msg.sender);
        addrTofund[msg.sender] = msg.value;
    }

    function withdraw() public {}
}
