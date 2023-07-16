import FungibleToken from 0xFungibleToken

pub contract TokenBurningContract {
    // Storage variables
    pub let tokenProvider: Capability<&{FungibleToken.FungibleTokenReceiver}>

    // Function to burn tokens
    pub fun burnTokens(amount: UFix64) {
        pre {
            amount > 0.0: "Invalid token amount"
        }

        // Burn tokens by transferring them to the contract
        FungibleToken.withdraw(from: <-self.tokenProvider.borrow()!, amount: amount)
        // The contract does not deposit the burned tokens back to any address
        // Instead, they are permanently removed from circulation
    }
}
