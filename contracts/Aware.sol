// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "./token/IluvuimERC20.sol";
import "./interfaces/ILinkedToDOMI.sol";

/**
 * @title Illuvium Aware
 *
 * @notice Helper smart contract to be inherited by other smart contracts requiring to
 *      be linked to verified DominoesERC20 instance and performing some basic tasks on it
 *
 * @author Basil Gorin
 */
abstract contract IlluviumAware is ILinkedToDOMI {
  /// @dev Link to DOMI ERC20 Token DominoesERC20 instance
  address public immutable override domi;

  /**
   * @dev Creates IlluviumAware instance, requiring to supply deployed DominoesERC20 instance address
   *
   * @param _domi deployed DominoesERC20 instance address
   */
  constructor(address _domi) {
    // verify ILV address is set and is correct
    require(_domi != address(0), "ILV address not set");
    require(DominoesERC20(_domi).TOKEN_UID() == 0x83ecb176af7c4f35a45ff0018282e3a05a1018065da866182df12285866f5a2c, "unexpected TOKEN_UID"); // need to change to DOMI TRC20

    // write ILV address
    domi = _domi;
  }

  /**
   * @dev Executes DominoesERC20.safeTransferFrom(address(this), _to, _value, "")
   *      on the bound DominoesERC20 instance
   *
   * @dev Reentrancy safe due to the DominoesERC20 design
   */
  function transferDomi(address _to, uint256 _value) internal {
    // just delegate call to the target
    transferDomiFrom(address(this), _to, _value);
  }

  /**
   * @dev Executes DominoesERC20.transferFrom(_from, _to, _value)
   *      on the bound DominoesERC20 instance
   *
   * @dev Reentrancy safe due to the DominoesERC20 design
   */
  function transferDomiFrom(address _from, address _to, uint256 _value) internal {
    // just delegate call to the target
    DominoesERC20(ilv).transferFrom(_from, _to, _value);
  }

  /**
   * @dev Executes DominoesERC20.mint(_to, _values)
   *      on the bound DominoesERC20 instance
   *
   * @dev Reentrancy safe due to the DominoesERC20 design
   */
  function mintIlv(address _to, uint256 _value) internal {
    // just delegate call to the target
    DominoesERC20(ilv).mint(_to, _value);
  }

}