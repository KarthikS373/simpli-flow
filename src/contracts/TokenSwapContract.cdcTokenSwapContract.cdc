import FungibleToken from 0xFungibleToken

pub contract TokenSwapContract {
    // Storage variables
    pub let tokenA: Capability<&{FungibleToken.FungibleTokenReceiver}>
    pub let tokenB: Capability<&{FungibleToken.FungibleTokenReceiver}>
    pub let swapRatio: UFix64

    // Event emitted when a token swap occurs
    pub event TokenSwap(Address, UFix64, Address, UFix64)

    // Function to swap token A for token B
    pub fun swapTokens() {
        // Transfer token A from the caller to the contract
        let tokenABalance = FungibleToken.balance<TokenA>(from: <-self.tokenA.borrow()!)
        let tokenBAmount = tokenABalance * self.swapRatio

        // Transfer token B from the contract to the caller
        FungibleToken.withdraw(from: <-self.tokenA.borrow()!, amount: tokenABalance)
        FungibleToken.deposit(to: self.account, amount: tokenBAmount)

        // Emit the TokenSwap event
        emit TokenSwap(self.account.address, tokenABalance, self.account.address, tokenBAmount)
    }
}
