pub contract DataMarketplaceContract {
    // Storage variables
    pub var dataProviders: {Address: [UInt64]}

    // Function to register as a data provider
    pub fun registerDataProvider(dataProvider: Address, dataIDs: [UInt64]) {
        // Store the data IDs provided by the data provider
        self.dataProviders[dataProvider] = dataIDs
    }

    // Function to get the data IDs provided by a data provider
    pub fun getDataIDs(dataProvider: Address): [UInt64] {
        return self.dataProviders[dataProvider] ?? []
    }
}
