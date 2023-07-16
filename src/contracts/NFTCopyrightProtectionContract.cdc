import NonFungibleToken from 0xNonFungibleToken

pub contract NFTCopyrightProtectionContract {
    // Storage variables
    pub var creators: {UInt64: Address}

    // Function to register the creator of an NFT
    pub fun registerCreator(nftID: UInt64) {
        // Set the creator for the NFT
        self.creators[nftID] = self.account.address
    }

    // Function to check if an address is the creator of an NFT
    pub fun isCreator(address: Address, nftID: UInt64): Bool {
        return self.creators[nftID] == address
    }
}
