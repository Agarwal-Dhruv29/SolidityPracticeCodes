// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

contract test4 {

    mapping(address => uint) public balanceReceived;
    address payable owner = payable(msg.sender);
    address payable myAddress;
    address payable feeAddress;
    //address payable feeAddress2; 
    
    constructor() {
        owner = payable(msg.sender);
    }

    function setMyAddress(address payable _myAddress) public payable {
        require(msg.sender == owner, "you are not the owner");
        myAddress = _myAddress;
    }
    function setFeeAddress(address payable _feeAddress) public payable {
        require(msg.sender == owner, "you are not the owner");
        feeAddress = _feeAddress;
    }
    function receiveMoney() public payable {
        require(msg.sender != myAddress, "you cannot call function");
        myAddress.transfer(msg.value / 2);
        feeAddress.transfer((msg.value / 2) * 10 / 100);
        balanceReceived[msg.sender] = msg.value;
        
    }
    function getBalance () public view returns (uint) {
        return address(this).balance;
    }
    function withdrawAllMoney() public {
        require(msg.sender == owner, "not owner");
        payable(msg.sender).transfer(getBalance());
    }
}