// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

/**
 * @title Linked to DOMI Marker Interface
 *
 * @notice Marks smart contracts which are linked to DominoesERC20 token instance upon construction,
 *      all these smart contracts share a common domi() address getter
 *
 * @notice Implementing smart contracts MUST verify that they get linked to real DominoesERC20 instance
 *      and that domi() getter returns this very same instance address
 *
 * @author Basil Gorin
 */
interface ILinkedToDOMI {
  /**
   * @notice Getter for a verified DominoesERC20 instance address
   *
   * @return DominoesERC20 token instance address smart contract is linked to
   */
  function domi() external view returns (address);
}