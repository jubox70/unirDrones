// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";




contract MyTokenERC20  is ERC20 {

    constructor() ERC20("MyTokenERC20", "MTK") {
        
        _mint(msg.sender, 1000000000000000000000000000000000000);
    }

    


}