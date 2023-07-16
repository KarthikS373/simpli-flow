pub contract EscrowContract {
    // Storage variables
    pub var seller: Address
    pub var buyer: Address
    pub var amount: UFix64
    pub var isFundsReleased: Bool

    // Event emitted when funds are released
    pub event FundsReleased()

    // Function to initialize the contract
    init(sellerAddress: Address, buyerAddress: Address, contractAmount: UFix64) {
        self.seller = sellerAddress
        self.buyer = buyerAddress
        self.amount = contractAmount
        self.isFundsReleased = false
    }

    // Function to release funds to the seller
    pub fun releaseFunds() {
        // Ensure the caller is the buyer
        pre {
            self.account.address == self.buyer: "Unauthorized"
        }

        // Release the funds to the seller
        self.isFundsReleased = true

        // Emit the FundsReleased event
        emit FundsReleased()
    }
}
