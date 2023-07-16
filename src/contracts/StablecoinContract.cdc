import FungibleToken from 0xFungibleToken

pub contract StablecoinContract {
    // Storage variables
    pub let tokenProvider: Capability<&{FungibleToken.FungibleTokenReceiver}>

    // Function to issue new stablecoin tokens
    pub fun issueTokens(amount: UFix64) {
        pre {
            amount > 0.0: "Invalid token amount"
        }

        // Mint new stablecoin tokens by depositing them to the contract
        FungibleToken.deposit(to: <-self.tokenProvider.borrow()!, amount: amount)
    }

    // Function to redeem stablecoin tokens
    pub fun redeemTokens(amount: UFix64) {
        pre {
            amount > 0.0: "Invalid token amount"
        }

        // Burn stablecoin tokens by withdrawing them from the contract
        FungibleToken.withdraw(from: <-self.tokenProvider.borrow()!, amount: amount)
    }
}
