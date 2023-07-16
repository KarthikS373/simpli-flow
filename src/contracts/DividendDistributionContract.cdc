import FungibleToken from 0xFungibleToken

pub contract DividendDistributionContract {
    // Storage variables
    pub let tokenProvider: Capability<&{FungibleToken.FungibleTokenReceiver}>

    // Function to distribute dividends to token holders
    pub fun distributeDividends(amount: UFix64) {
        pre {
            amount > 0.0: "Invalid dividend amount"
        }

        let totalSupply = FungibleToken.balance<Token>(from: <-self.tokenProvider.borrow()!)

        // Calculate the dividend per token
        let dividendPerToken = amount / totalSupply

        // Iterate through all token holders and distribute dividends
        for tokenHolder in FungibleToken.accounts<Token>() {
            let balance = FungibleToken.balance<Token>(from: <-self.tokenProvider.borrow()!, at: tokenHolder)

            // Calculate the dividend amount for the token holder
            let dividendAmount = balance * dividendPerToken

            // Transfer the dividend to the token holder
            FungibleToken.deposit(to: tokenHolder, amount: dividendAmount)
        }
    }
}
