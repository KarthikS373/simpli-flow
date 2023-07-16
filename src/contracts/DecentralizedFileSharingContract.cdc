pub contract DecentralizedFileSharingContract {
    // Storage variables
    pub var files: {String: Address}

    // Function to upload a file
    pub fun uploadFile(fileHash: String) {
        self.files[fileHash] = self.account.address
    }

    // Function to download a file
    pub fun downloadFile(fileHash: String): Address {
        return self.files[fileHash] ?? Address(0)
    }
}
