import FungibleToken from 0xFungibleToken

pub contract WrappedTokensContract {
    // Storage variables
    pub let tokenProvider: Capability<&{FungibleToken.FungibleTokenReceiver}>

    // Function to wrap tokens
    pub fun wrapTokens(amount: UFix64) {
        pre {
            amount > 0.0: "Invalid token amount"
        }

        // Transfer the tokens from the caller to the contract
        FungibleToken.withdraw(from: self.account, amount: amount)
        FungibleToken.deposit(to: <-self.tokenProvider.borrow()!, amount: amount)
    }

    // Function to unwrap tokens
    pub fun unwrapTokens(amount: UFix64) {
        pre {
            amount > 0.0: "Invalid token amount"
        }

        // Transfer the tokens from the contract to the caller
        FungibleToken.withdraw(from: <-self.tokenProvider.borrow()!, amount: amount)
        FungibleToken.deposit(to: self.account, amount: amount)
    }
}
