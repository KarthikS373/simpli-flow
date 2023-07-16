pub contract DecentralizedStorageContract {
    // Storage variables
    pub var data: {String: String}

    // Function to store data
    pub fun storeData(key: String, value: String) {
        self.data[key] = value
    }

    // Function to retrieve data
    pub fun retrieveData(key: String): String {
        return self.data[key] ?? ""
    }
}
