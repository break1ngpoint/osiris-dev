pragma solidity ^0.4.24;

import "github.com/OpenZeppelin/zeppelin-solidity/contracts/math/SafeMath.sol";

contract MyContract {
    using SafeMath for uint256;    
    function SafeAdd(uint256 a, uint256 b) public pure returns(uint256) {
      return a.add(b);
    }
}
