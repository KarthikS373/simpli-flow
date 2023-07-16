import FungibleToken from 0xFungibleToken

pub contract TokenVestingContract {
    // Storage variables
    pub let beneficiary: Address
    pub let startTime: UInt64
    pub let vestingDuration: UInt64
    pub var isVestingComplete: Bool
    pub let tokenProvider: Capability<&{FungibleToken.FungibleTokenReceiver}>

    // Event emitted when tokens are released
    pub event TokensReleased(UFix64)

    // Function to initialize the contract
    init(beneficiaryAddress: Address, duration: UInt64) {
        self.beneficiary = beneficiaryAddress
        self.startTime = getCurrentBlockTime()
        self.vestingDuration = duration
        self.isVestingComplete = false
    }

    // Function to release vested tokens
    pub fun releaseTokens() {
        pre {
            getCurrentBlockTime() >= self.startTime + self.vestingDuration: "Tokens are still locked"
            !self.isVestingComplete: "Tokens already released"
        }

        let vestingPeriod = self.vestingDuration - (self.startTime - getCurrentBlockTime())
        let totalTokens = FungibleToken.balance<Token>(from: <-self.tokenProvider.borrow()!)

        let tokensToRelease = totalTokens * UFix64(vestingPeriod) / UFix64(self.vestingDuration)

        // Transfer the vested tokens to the beneficiary
        FungibleToken.withdraw(from: <-self.tokenProvider.borrow()!, amount: tokensToRelease)
        FungibleToken.deposit(to: self.beneficiary, amount: tokensToRelease)

        self.isVestingComplete = true

        // Emit the TokensReleased event
        emit TokensReleased(tokensToRelease)
    }
}
