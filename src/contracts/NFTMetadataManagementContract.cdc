import NonFungibleToken from 0xNonFungibleToken

pub contract NFTMetadataManagementContract {
    // Storage variables
    pub var nftMetadata: {UInt64: String}

    // Function to set metadata for an NFT
    pub fun setNFTMetadata(nftID: UInt64, metadata: String) {
        // Set the metadata for the NFT
        self.nftMetadata[nftID] = metadata
    }

    // Function to get metadata for an NFT
    pub fun getNFTMetadata(nftID: UInt64): String {
        return self.nftMetadata[nftID] ?? ""
    }
}
