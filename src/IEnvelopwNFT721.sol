// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import "./LibEnvelopTypes.sol";

interface IEnvelopwNFT721 {
    function wnftInfo(uint256 tokenId) external view returns (ETypes.WNFT memory);
}
