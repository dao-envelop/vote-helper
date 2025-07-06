// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {Script, console2} from "forge-std/Script.sol";
import "../lib/forge-std/src/StdJson.sol";
import "../src/EnvelopSBTV1VoteHelper.sol";


// This abstarct contract describe deploy and instantionate rules in project
// Base logic is following
// if address exists in  `chain_params.json` then no deployments will occure but only instance
// All deploy actions  are always in inheritors
abstract contract Objects is Script{
    using stdJson for string;
    struct Params {
        address niftsy_erc20;
        address sbtv1_address;  
    }

    Params p;

    string public params_json_file = vm.readFile(string.concat(vm.projectRoot(), "/script/chain_params.json"));
 
    string public params_json_file2 = vm.readFile(string.concat(vm.projectRoot(), "/script/explorers.json"));
    string public explorer_url = params_json_file2.readString(
        string.concat(".", vm.toString(block.chainid))
    );

    EnvelopSBTV1VoteHelper voteHelper;

    function getChainParams() internal {
        // Load json with chain params
        
        string memory key;
        
        console2.log("\n     **Network settings from file**  ");
        // Define constructor params
        key = string.concat(".", vm.toString(block.chainid),".niftsy_erc20");
        if (vm.keyExists(params_json_file, key)) 
        {
            p.niftsy_erc20 = params_json_file.readAddress(key);
        } else {
            p.niftsy_erc20 = address(0);
        }
        console2.log("key: %s, value:%s", key, p.niftsy_erc20);

        key = string.concat(".", vm.toString(block.chainid),".sbtv1_address");
        if (vm.keyExists(params_json_file, key)) 
        {
            p.sbtv1_address = params_json_file.readAddress(key);
        } else {
            p.sbtv1_address = address(0);
        }
        console2.log("key: %s, value:%s", key, p.sbtv1_address);

    }

    function deployOrInstances(bool onlyInstance) internal {
        //factory = EnvelopWNFTFactory(0x431Db5c6ce5D85A0BAa2198Aa7Aa0E65d37a25c8);
        voteHelper = new EnvelopSBTV1VoteHelper(p.sbtv1_address, p.niftsy_erc20);
        //vm.stopBroadcast();
        console2.log("Instances ready....");

    }

    function prettyPrint() internal view {
        ///////// Pretty printing ////////////////
        
        console2.log("\n**EnvelopSBTV1VoteHelper**  ");
        console2.log("https://%s/address/%s#code\n", explorer_url, address(voteHelper));
        
    }

}

