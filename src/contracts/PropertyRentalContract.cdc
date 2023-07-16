pub contract PropertyRentalContract {
    // Storage variables
    pub var rentalProperties: {UInt64: Address}

    // Function to list a property for rental
    pub fun listPropertyForRental(propertyID: UInt64) {
        // Store the owner's address for the rental property
        self.rentalProperties[propertyID] = self.account.address
    }

    // Function to remove a property from rental listings
    pub fun removePropertyFromRental(propertyID: UInt64) {
        // Remove the property from the list of rental properties
        self.rentalProperties.remove(propertyID)
    }

    // Function to get the owner's address for a rental property
    pub fun getPropertyOwner(propertyID: UInt64): Address {
        return self.rentalProperties[propertyID] ?? Address(0)
    }
}
