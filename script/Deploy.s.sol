// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "./Objects.s.sol";


/// Deploy and init actions
contract DeployScript is Script, Objects {
    using stdJson for string;

    function run() public {
        console2.log("Chain id: %s", vm.toString(block.chainid));
        console2.log(
            "Deployer address: %s, "
            "\n native balnce %s",
            msg.sender, msg.sender.balance
        );
         
        getChainParams();

        //////////   Deploy   //////////////
        vm.startBroadcast();
        deployOrInstances(false);
        vm.stopBroadcast();

        prettyPrint(); 
        
   
        // ///////// End of pretty printing ////////////////
        
        // ///  Init ///
        
}



}