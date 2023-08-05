This is a project for own ERC20 Token, currenly deployed on SEPOLIA testnet and contract address is as below :
0xC54D08C80e563d0c39610d8Ad81b05fC79dADd2e

Token has below properties :
1. Capped with 100000000 NMT.
2. Burnable
3. It gives rewards to the miners for each block. Current block reward is set to 50 NMT and we can change it by calling :

```
setBlockReward(uint256 _blockReward);
```

Only owner can call this function.

to run it locally you will need below tools :

1. node js
2. hardhat
