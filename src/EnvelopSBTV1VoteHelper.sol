// SPDX-License-Identifier: MIT
// Based on https://github.com/compound-developers/compound-3-developer-faq
import "./LibEnvelopTypes.sol";
import "./IERC20Read.sol";
import "./IERC721Enumerable.sol";
import "./IERC721Metadata.sol";
pragma solidity 0.8.28;

 

interface ISBTLight is IERC721Enumerable, IERC721Metadata {
        /// @notice returns general data for `token_` such as rates, exchange prices, utilization, fee, total amounts etc.
    function wnftInfo(uint256 _tokenId) 
        external 
        view 
        returns (ETypes.WNFT memory wnft);


}

contract EnvelopSBTV1VoteHelper {
    
    uint256 constant public  DEFAULT_WRAPPED_MULTIPLIER = 3;
    address immutable public DEFAULT_WNFT_CONTRACT;
    address immutable public DEFAULT_ERC20_COLLATERAL;


    constructor(address _defaultWNFT, address _defaultERC20) {
        DEFAULT_WNFT_CONTRACT = _defaultWNFT;
        DEFAULT_ERC20_COLLATERAL = _defaultERC20;

    }

    function getWrappedBalance(
        address _user,
        address _erc20,
        address _wnftAddress
    ) 
        external 
        view 
        returns(uint256 wrappedBalance) 
    {
        return _getWrappedBalance(_user, _erc20, _wnftAddress);
    }

    function balanceOf(address _user) external view returns (uint256) {

        return IERC20Read(DEFAULT_ERC20_COLLATERAL).balanceOf(_user) 
            + _getWrappedBalance(_user, DEFAULT_ERC20_COLLATERAL, DEFAULT_WNFT_CONTRACT)
            * DEFAULT_WRAPPED_MULTIPLIER;
    }

    function _getWrappedBalance(
        address _user,
        address _erc20,
        address _wnftAddress
    ) 
        internal 
        view 
        returns(uint256 wrappedBalance) 
    {
        // First lets obtain all user's SBTs
        uint256 sbtCount =  ISBTLight(_wnftAddress).balanceOf(_user);
        // Now we have to check every sbt: how much exect erc20 balance it has
        for (uint256 i = 0; i < sbtCount; ++ i) {
            uint256 _tokenId = ISBTLight(_wnftAddress).tokenOfOwnerByIndex(_user, i);
            ETypes.WNFT memory _wnft = ISBTLight(_wnftAddress).wnftInfo(_tokenId);
            for (uint256 j = 0; j < _wnft.collateral.length; ++ j) {
                if (_wnft.collateral[j].asset.contractAddress == _erc20) {
                    wrappedBalance += _wnft.collateral[j].amount;
                }
            }

        }
        
    }

}