import FungibleToken from 0xFungibleToken

pub contract TokenizedRewardsProgramContract {
    // Storage variables
    pub var rewards: {Address: UFix64}

    // Function to issue rewards
    pub fun issueRewards(amount: UFix64) {
        // Issue rewards to the caller's address
        self.rewards[self.account.address] += amount
    }

    // Function to redeem rewards
    pub fun redeemRewards(amount: UFix64) {
        // Ensure the caller has enough rewards
        pre {
            self.rewards[self.account.address] >= amount: "Insufficient rewards"
        }

        // Redeem rewards from the caller's address
        self.rewards[self.account.address] -= amount
    }
}
