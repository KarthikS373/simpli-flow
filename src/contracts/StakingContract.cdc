import FungibleToken from 0xFungibleToken

pub contract StakingContract {
    // Struct representing a stake
    pub struct Stake {
        pub var amount: UFix64
        pub var staker: Address
        pub var isLocked: Bool
    }

    // Collection to store stakes
    pub var stakes: {UInt64: Stake}

    // Reference to the FungibleToken contract
    pub let tokenProvider: Capability<&{FungibleToken.FungibleTokenReceiver}>

    // Event emitted when a stake is made
    pub event StakeMade(
        id: UInt64,
        staker: Address,
        amount: UFix64
    )

    // Event emitted when a stake is unlocked
    pub event StakeUnlocked(
        id: UInt64,
        staker: Address,
        amount: UFix64
    )

    // Function to make a stake
    pub fun makeStake(amount: UFix64): UInt64 {
        let stakeID: UInt64 = self.borrowNextStakeID()
        let stake = Stake(amount: amount, staker: self.account.address, isLocked: true)
        self.stakes[stakeID] = stake

        // Emit the StakeMade event
        emit StakeMade(id: stakeID, staker: self.account.address, amount: amount)

        // Transfer tokens from the staker to the contract
        FungibleToken.withdraw(from: <-tokenProvider.borrow()!, amount: amount)

        return stakeID
    }

    // Function to unlock a stake
    pub fun unlockStake(stakeID: UInt64) {
        let stake = self.stakes[stakeID]

        // Ensure the stake exists and is owned by the caller
        pre {
            stake.staker == self.account.address: "Unauthorized"
            stake.isLocked: "Stake is already unlocked"
        }

        // Unlock the stake
        stake.isLocked = false

        // Emit the StakeUnlocked event
        emit StakeUnlocked(id: stakeID, staker: self.account.address, amount: stake.amount)
    }

    // Function to retrieve the details of a stake
    pub fun getStake(stakeID: UInt64): Stake {
        return self.stakes[stakeID]
    }
}
