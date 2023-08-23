// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Inbox {
    string public message;

    constructor(string memory _message) {
        message = _message;
    }

    function setMessage(string memory _message) public {
        message = _message;
    }
}
