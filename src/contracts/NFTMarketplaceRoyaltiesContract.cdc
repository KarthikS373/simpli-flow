import NonFungibleToken from 0xNonFungibleToken

pub contract NFTMarketplaceRoyaltiesContract {
    // Storage variables
    pub var royalties: {Address: UFix64}

    // Function to set royalties for a marketplace
    pub fun setRoyalties(marketplace: Address, royaltyPercentage: UFix64) {
        // Set the royalties percentage for the given marketplace
        self.royalties[marketplace] = royaltyPercentage
    }

    // Function to get royalties for a marketplace
    pub fun getRoyalties(marketplace: Address): UFix64 {
        return self.royalties[marketplace] ?? 0.0
    }
}
