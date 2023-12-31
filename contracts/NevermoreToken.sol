//initial supply : 70,000,000
//capped Supply : Take from User
//

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract NevermoreToken is ERC20Capped, ERC20Burnable {
    address payable public owner;
    uint256 public blockReward;

    constructor(
        uint256 cap,
        uint256 _blockReward
    ) ERC20("NevermoreToken", "NMT") ERC20Capped(cap * (10 ** decimals())) {
        owner = payable(msg.sender);
        blockReward = _blockReward * (10 ** decimals());
        _mint(msg.sender, 70000000 * (10 ** decimals()));
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can do this operation");
        _;
    }

    function setBlockReward(uint256 _blockReward) public onlyOwner {
        blockReward = _blockReward * (10 ** decimals());
    }

    function _mint_minerReward() internal {
        _mint(block.coinbase, blockReward);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 value
    ) internal virtual override {
        if (
            from != address(0) &&
            to != block.coinbase &&
            block.coinbase != address(0)
        ) {
            _mint_minerReward();
        }
        super._beforeTokenTransfer(from, to, value);
    }

    function destroy() public onlyOwner {
        selfdestruct(owner);
    }

    function _mint(
        address account,
        uint256 amount
    ) internal virtual override(ERC20Capped, ERC20) {
        require(
            ERC20.totalSupply() + amount <= cap(),
            "ERC20Capped: cap exceeded"
        );
        super._mint(account, amount);
    }
}
