import FungibleToken from 0xFungibleToken

pub contract TokenDistributionContract {
    // Storage variables
    pub let tokenProvider: Capability<&{FungibleToken.FungibleTokenReceiver}>

    // Function to distribute tokens to multiple recipients
    pub fun distributeTokens(recipients: [Address], amounts: [UFix64]) {
        pre {
            recipients.length == amounts.length: "Recipient and amount arrays must have the same length"
        }

        for i in 0 ..< recipients.length {
            let recipient = recipients[i]
            let amount = amounts[i]

            // Transfer tokens from the contract to the recipient
            FungibleToken.withdraw(from: <-self.tokenProvider.borrow()!, amount: amount)
            FungibleToken.deposit(to: recipient, amount: amount)
        }
    }
}
