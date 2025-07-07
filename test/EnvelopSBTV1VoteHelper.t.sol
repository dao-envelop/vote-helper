// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import "../src/EnvelopSBTV1VoteHelper.sol";
import "../src/IEnvelopwNFT721.sol";

contract EnvelopSBTV1VoteHelperTest is Test {
    EnvelopSBTV1VoteHelper public voteHelper;
    address public constant NIFTSY = 0x432cdbC749FD96AA35e1dC27765b23fDCc8F5cf1;
    address public constant SBT = 0xf2B919B54848639e552C697D6F39a544AC6D2328;
    address public constant user1 = 0x39cc948dA00d2E2a09Ed4D508768a92e0A3BBE6A;
    address public constant user2 = 0xF8E02D473710506DB5D9210D96725cccbf4137c9;
    address public constant user3 = 0xf315B9006C20913D6D8498BDf657E778d4Ddf2c4;
    address public constant voterAddress = 0xBDb5201565925AE934A5622F0E7091aFFceed5EB;

    function setUp() public {
        voteHelper = EnvelopSBTV1VoteHelper(voterAddress);
    }

    function test_network_forked() public view {
        if (block.chainid == 137) {
            uint256 ts = IERC20Read(NIFTSY).totalSupply();
            assertGt(ts, 1000e18);
        } else {
            console2.log("Test can be run on forked Polygon chain. Current chainid: %s", vm.toString(block.chainid));
        }
    }

    function test_one_sbt_and_balance() public view {
        uint256 niftsyBalance = IERC20Read(NIFTSY).balanceOf(user1);
        ETypes.WNFT memory wnft = IEnvelopwNFT721(SBT).wnftInfo(1);
        uint256 collateral = wnft.collateral[0].amount;
        uint256 expectedAmount = niftsyBalance + voteHelper.DEFAULT_WRAPPED_MULTIPLIER() * collateral;
        uint256 actualAmount = voteHelper.balanceOf(user1);
        assertEq(expectedAmount, actualAmount);
    }

    function test_without_any_balance() public view {
        uint256 niftsyBalance = IERC20Read(NIFTSY).balanceOf(user2);
        uint256 expectedAmount = niftsyBalance;
        uint256 actualAmount = voteHelper.balanceOf(user2);
        assertEq(expectedAmount, actualAmount);
    }

    function test_only_balance() public view {
        uint256 niftsyBalance = IERC20Read(NIFTSY).balanceOf(user3);
        uint256 expectedAmount = niftsyBalance;
        assertGt(expectedAmount, 1);
        uint256 actualAmount = voteHelper.balanceOf(user3);
        assertEq(expectedAmount, actualAmount);
    }
}
