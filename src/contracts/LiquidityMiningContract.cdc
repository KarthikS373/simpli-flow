import FungibleToken from 0xFungibleToken
import FlowToken from 0xFlowToken

pub contract LiquidityMiningContract {
    // Storage variables
    pub var rewardsToken: @FungibleToken.T
    pub var poolToken: @FungibleToken.T
    pub var rewardsPerBlock: UFix64
    pub var lastBlockHeight: UInt64

    // Function to initialize the liquidity mining contract
    pub fun init(
        rewardsTokenAddress: Address,
        poolTokenAddress: Address,
        rewardsPerBlock: UFix64
    ) {
        self.rewardsToken = getAccount(rewardsTokenAddress)
            .getCapability<&FungibleToken.T{FungibleToken.Balance}>(
                /public/token-balance
            )
            .borrow() ?? panic("Failed to borrow rewards token capability")

        self.poolToken = getAccount(poolTokenAddress)
            .getCapability<&FungibleToken.T{FungibleToken.Balance}>(
                /public/token-balance
            )
            .borrow() ?? panic("Failed to borrow pool token capability")

        self.rewardsPerBlock = rewardsPerBlock
        self.lastBlockHeight = getCurrentBlock().height
    }

    // Function to update the rewards distribution
    pub fun updateRewards() {
        let currentBlockHeight = getCurrentBlock().height
        let blocksElapsed = currentBlockHeight - self.lastBlockHeight

        if blocksElapsed > 0 {
            // Calculate the rewards to distribute
            let rewardsToDistribute = blocksElapsed * self.rewardsPerBlock

            // Transfer rewards tokens to the contract
            self.rewardsToken.transfer(to: self.address, amount: rewardsToDistribute)

            // Calculate the total supply of pool tokens
            let totalSupply = self.poolToken.totalSupply

            // Distribute rewards proportionally to pool token holders
            if totalSupply > 0 {
                let rewardPerToken = rewardsToDistribute / totalSupply

                for tokenHolder in self.poolToken.getHoldings() {
                    let balance = self.poolToken.balanceOf(owner: tokenHolder)

                    if balance > 0 {
                        let rewards = rewardPerToken * balance
                        self.rewardsToken.transfer(to: tokenHolder, amount: rewards)
                    }
                }
            }

            self.lastBlockHeight = currentBlockHeight
        }
    }
}
