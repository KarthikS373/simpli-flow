pub contract LogisticsContract {
    // Storage variables
    pub var packages: {UInt64: Address}

    // Function to initiate a package delivery
    pub fun initiateDelivery(packageID: UInt64) {
        // Store the recipient's address for the package
        self.packages[packageID] = self.account.address
    }

    // Function to cancel a package delivery
    pub fun cancelDelivery(packageID: UInt64) {
        // Remove the package from the list of packages
        self.packages.remove(packageID)
    }

    // Function to get the recipient's address for a package
    pub fun getPackageRecipient(packageID: UInt64): Address {
        return self.packages[packageID] ?? Address(0)
    }
}
