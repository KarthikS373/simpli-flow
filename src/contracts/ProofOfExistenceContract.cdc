pub contract ProofOfExistenceContract {
    // Storage variables
    pub var documents: {String: Address}

    // Event emitted when a document is registered
    pub event DocumentRegistered(String, Address)

    // Function to register a document
    pub fun registerDocument(documentHash: String) {
        // Ensure the document is not already registered
        pre {
            !self.documents.containsKey(documentHash): "Document already registered"
        }

        // Register the document with the caller's address
        self.documents[documentHash] = self.account.address

        // Emit the DocumentRegistered event
        emit DocumentRegistered(documentHash, self.account.address)
    }

    // Function to check if a document is registered
    pub fun isDocumentRegistered(documentHash: String): Bool {
        return self.documents.containsKey(documentHash)
    }
}
