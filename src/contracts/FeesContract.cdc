pub contract FeesContract {
    // Event emitted when fees are collected
    pub event FeesCollected(
        recipient: Address,
        amount: UFix64
    )

    // Function to collect fees
    pub fun collectFees(recipient: Address, amount: UFix64) {
        // Perform any necessary checks or validations here
        
        // Transfer the fee amount to the recipient
        if amount > 0.0 {
            recipient.account.balance += amount
        }

        // Emit the FeesCollected event
        emit FeesCollected(recipient: recipient, amount: amount)
    }
}
