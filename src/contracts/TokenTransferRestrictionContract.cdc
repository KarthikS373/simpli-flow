import FungibleToken from 0xFungibleToken

pub contract TokenTransferRestrictionContract {
    // Storage variables
    pub var transferAllowed: Bool
    pub let tokenProvider: Capability<&{FungibleToken.FungibleTokenReceiver}>

    // Function to allow token transfers
    pub fun allowTransfers() {
        // Ensure the caller has the authority to allow transfers
        pre {
            // Add the necessary condition for caller authorization
        }

        self.transferAllowed = true
    }

    // Function to restrict token transfers
    pub fun restrictTransfers() {
        // Ensure the caller has the authority to restrict transfers
        pre {
            // Add the necessary condition for caller authorization
        }

        self.transferAllowed = false
    }

    // Function to check if token transfers are allowed
    pub fun areTransfersAllowed(): Bool {
        return self.transferAllowed
    }
}
