//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mock/MockV3Aggregator.sol";
contract HelperConfig is Script {
    NetWorkConfig public nowChain;
    constructor() {
        if(block.chainid == 11155111) {
            nowChain = getSepoliaConfig();
        }else if (block.chainid == 1) {
            nowChain = getMainNetConfig();
        }else{
            nowChain = getGoerliConfig();
        }
    }

    struct NetWorkConfig {
        address priceFeed;
    }

    function getSepoliaConfig() public pure returns (NetWorkConfig memory) {
        NetWorkConfig memory sepoliaFeed = NetWorkConfig({
            priceFeed: 0x5fb1616F78dA7aFC9FF79e0371741a747D2a7F22
        });
        return sepoliaFeed;
    }

    function getGoerliConfig() public returns (NetWorkConfig memory) {
        if (nowChain.priceFeed != address(0)) {
            return nowChain;
        }
        vm.startBroadcast();
        MockV3Aggregator aggregator = new MockV3Aggregator(8,2000e8);
        vm.stopBroadcast();
        NetWorkConfig memory goerliFeed = NetWorkConfig({
            priceFeed: address(aggregator)
        });
        return goerliFeed;
    }

    function getMainNetConfig() public pure returns (NetWorkConfig memory) {
        NetWorkConfig memory mainFeed = NetWorkConfig({
            priceFeed:0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        });
        return mainFeed;
    }
}