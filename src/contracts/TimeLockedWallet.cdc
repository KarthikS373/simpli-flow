import FungibleToken from 0xFungibleToken

pub contract TimeLockedWallet {
    // Storage variables
    pub let beneficiary: Address
    pub let releaseTime: UInt64
    pub var isReleased: Bool
    pub let tokenProvider: Capability<&{FungibleToken.FungibleTokenReceiver}>

    // Event emitted when funds are released
    pub event FundsReleased()

    // Function to initialize the contract
    init(beneficiaryAddress: Address, lockDuration: UInt64) {
        self.beneficiary = beneficiaryAddress
        self.releaseTime = getCurrentBlockTime() + lockDuration
        self.isReleased = false
    }

    // Function to release funds
    pub fun releaseFunds() {
        pre {
            getCurrentBlockTime() >= self.releaseTime: "Funds are still locked"
            !self.isReleased: "Funds already released"
        }

        // Transfer the locked funds to the beneficiary
        let balance = FungibleToken.balance<Token>(from: <-self.tokenProvider.borrow()!)
        FungibleToken.withdraw(from: <-self.tokenProvider.borrow()!, amount: balance)
        FungibleToken.deposit(to: self.beneficiary, amount: balance)

        self.isReleased = true

        // Emit the FundsReleased event
        emit FundsReleased()
    }
}
