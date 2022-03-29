// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

contract test4 {

    mapping(address => uint) public balanceReceived;
    mapping(address => uint) public timeRecorded;
    mapping(address => string) public senderName;
    address payable owner = payable(msg.sender);
    address payable feeAddress;  
    
    constructor() {
        owner = payable(msg.sender);
    }
    function setFeeAddress(address payable _feeAddress) public payable {
        require(msg.sender == owner, "you are not the owner");
        feeAddress = _feeAddress;
    }
    function sendMoney(string memory _name) public payable {
        senderName[msg.sender] = _name;
        feeAddress.transfer(msg.value * 10 / 100);
        balanceReceived[msg.sender] += msg.value;
        timeRecorded[msg.sender] = block.timestamp;
    }
    function getBalance () public view returns (uint) {
        return address(this).balance;
    }
    function withdrawAllMoney() public {
        require(msg.sender == owner, "not owner");
        payable(msg.sender).transfer(getBalance());
    }
}