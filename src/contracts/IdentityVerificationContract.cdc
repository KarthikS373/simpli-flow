pub contract IdentityVerificationContract {
    // Storage variables
    pub var verifiedAddresses: {Address: Bool}

    // Function to verify an address
    pub fun verifyAddress(address: Address) {
        // Set the verification status for the address
        self.verifiedAddresses[address] = true
    }

    // Function to unverify an address
    pub fun unverifyAddress(address: Address) {
        // Remove the address from the list of verified addresses
        self.verifiedAddresses.remove(address)
    }

    // Function to check if an address is verified
    pub fun isAddressVerified(address: Address): Bool {
        return self.verifiedAddresses[address] ?? false
    }
}
