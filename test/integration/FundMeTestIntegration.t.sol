//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interaction.s.sol";
import {FundMe} from "../../src/FundMe.sol";
import {Test, console} from "forge-std/Test.sol";

contract InteractionsTest is Test {
    FundMe public fundMe;
    DeployFundMe deployFundMe;

    uint256 public constant SEND_VALUE = 0.1 ether;
    uint256 public constant STARTING_USER_BALANCE = 10 ether;
    address alice = makeAddr("alice");

    function setUp() external {
        deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(alice, STARTING_USER_BALANCE);
    }

    // function testUserCanFundAndOwnerWithdraw() public {
    //     uint256 preUserBalance = address(alice).balance;
    //     uint256 preOwnerBalance = address(fundMe.getowner()).balance;

    //     vm.startPrank(alice);
    //     fundMe.fund{value: SEND_VALUE}();
    //     vm.stopPrank();

    //     WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
    //     withdrawFundMe.withdrawFundMe(address(fundMe));

    //     uint256 afterUserBalance = address(alice).balance;
    //     uint256 afterOwnerBalance = address(fundMe.getowner()).balance;

    //     assertEq(address(fundMe).balance, 0);
    //     assertEq(afterUserBalance + SEND_VALUE, preUserBalance);
    //     assertEq(preOwnerBalance + SEND_VALUE, afterOwnerBalance);
    // }

    function testUserCanFundInteraction() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));
        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));
        assertEq(address(fundMe).balance, 0);
    }
}
