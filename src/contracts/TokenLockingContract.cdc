import FungibleToken from 0xFungibleToken

pub contract TokenLockingContract {
    // Storage variables
    pub var lockedTokens: {Address: UFix64}
    pub let tokenProvider: Capability<&{FungibleToken.FungibleTokenReceiver}>

    // Function to lock tokens
    pub fun lockTokens(amount: UFix64) {
        pre {
            amount > 0.0: "Invalid token amount"
        }

        let sender = self.account.address

        // Transfer tokens from the sender to the contract
        FungibleToken.withdraw(from: <-self.tokenProvider.borrow()!, amount: amount)
        FungibleToken.deposit(to: self.account, amount: amount)

        // Update the locked tokens for the sender
        self.lockedTokens[sender] += amount
    }

    // Function to unlock tokens
    pub fun unlockTokens(amount: UFix64) {
        let sender = self.account.address

        // Ensure the sender has enough locked tokens
        pre {
            self.lockedTokens[sender] >= amount: "Insufficient locked tokens"
        }

        // Transfer tokens from the contract back to the sender
        FungibleToken.withdraw(from: self.account, amount: amount)
        FungibleToken.deposit(to: <-self.tokenProvider.borrow()!, amount: amount)

        // Update the locked tokens for the sender
        self.lockedTokens[sender] -= amount
    }
}
