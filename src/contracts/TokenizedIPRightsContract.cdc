import FungibleToken from 0xFungibleToken

pub contract TokenizedIPRightsContract {
    // Storage variables
    pub var ipRights: {String: Address}

    // Function to tokenize intellectual property rights
    pub fun tokenizeIPRights(rightsID: String) {
        // Tokenize the intellectual property rights by associating them with the caller's address
        self.ipRights[rightsID] = self.account.address
    }

    // Function to transfer intellectual property rights
    pub fun transferIPRights(rightsID: String, recipient: Address) {
        // Transfer the intellectual property rights from the caller to the recipient
        self.ipRights[rightsID] = recipient
    }
}
