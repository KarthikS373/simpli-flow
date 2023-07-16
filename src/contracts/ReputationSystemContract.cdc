pub contract ReputationSystemContract {
    // Storage variables
    pub var reputations: {Address: UInt64}

    // Function to update the reputation of an address
    pub fun updateReputation(address: Address, reputation: UInt64) {
        // Set the reputation for the address
        self.reputations[address] = reputation
    }

    // Function to get the reputation of an address
    pub fun getReputation(address: Address): UInt64 {
        return self.reputations[address] ?? 0
    }
}
