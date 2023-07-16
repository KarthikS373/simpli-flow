pub contract NFTRoyaltiesContract {
    // Storage variables
    pub var royalties: {UInt64: UFix64}

    // Function to set royalties for an NFT
    pub fun setRoyalties(nftID: UInt64, royaltyPercentage: UFix64) {
        // Set the royalties percentage for the given NFT ID
        self.royalties[nftID] = royaltyPercentage
    }

    // Function to get royalties for an NFT
    pub fun getRoyalties(nftID: UInt64): UFix64 {
        return self.royalties[nftID] ?? 0.0
    }
}
