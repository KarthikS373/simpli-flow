import FungibleToken from 0xFungibleToken

pub contract TokenMintingContract {
    // Storage variables
    pub let tokenProvider: Capability<&{FungibleToken.FungibleTokenReceiver}>

    // Function to mint new tokens
    pub fun mintTokens(amount: UFix64) {
        pre {
            amount > 0.0: "Invalid token amount"
        }

        // Mint new tokens by depositing them to the contract
        FungibleToken.deposit(to: <-self.tokenProvider.borrow()!, amount: amount)
    }
}
