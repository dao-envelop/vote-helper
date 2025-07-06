// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import "../src/EnvelopSBTV1VoteHelper.sol";

contract EnvelopSBTV1VoteHelperTest is Test {
    EnvelopSBTV1VoteHelper public voteHelper;
    address constant public NIFTSY = 0x432cdbC749FD96AA35e1dC27765b23fDCc8F5cf1;
    address constant public SBT = 0xf2B919B54848639e552C697D6F39a544AC6D2328;


    function setUp() public {
        voteHelper = EnvelopSBTV1VoteHelper(SBT);
    }

    function test_network_forked() public view{
        if (block.chainid == 137) {
            uint256 ts = IERC20Read(NIFTSY).totalSupply();
            assertGt(ts, 1000e18);

        } else {
            console2.log(
                "Test can be run on forked Polygon chain. Current chainid: %s"
                , vm.toString(block.chainid)
            );
        }
    }


    // function test_getProtocolMetricsByAddress() public view {
    //     DD.ProtocolMetrics memory _m;
        
    //     for (uint8 i = 0; i < markets.length; i ++) {
    //         _m = flLiqHelper.getProtocolMetricsByAddress(markets[i]);

    //         console2.log(
    //            "TVL     in %s = %s, %s", 
    //             ERC20(markets[i]).name(),
    //             _m.metrics[0].value, _m.metrics[0].scale
    //         );
    //         console2.log(
    //            "Credits in %s = %s, %s", 
    //             ERC20(markets[i]).name(),
    //              _m.metrics[1].value, _m.metrics[1].scale
    //         );
    //         console2.log(
    //            "Full APR in %s = %s, %s", 
    //             ERC20(markets[i]).name(),
    //              _m.metrics[2].value, _m.metrics[2].scale
    //         );
    //         //assertEq(_m.metrics[2].value, aavev3Helper.getReserveData(markets[i]).currentLiquidityRate);
    //         //assertEq(_m.metrics[3].value -_m.metrics[2].value, cv3Helper.getRewardAprForSupplyBase(markets[i], cv3Helper.REWARD_PRICE_FEED()));
            
    //     }
    // }

}
