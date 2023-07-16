pub contract StorageContract {
    // Storage variable
    pub var storedData: String

    // Event emitted when data is stored
    pub event DataStored(
        storedBy: Address,
        newData: String
    )

    // Function to store data
    pub fun storeData(newData: String) {
        // Update the stored data
        self.storedData = newData

        // Emit the DataStored event
        emit DataStored(storedBy: self.account.address, newData: newData)
    }

    // Function to retrieve the stored data
    pub fun retrieveData(): String {
        return self.storedData
    }
}
