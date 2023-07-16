import NonFungibleToken from 0xNonFungibleToken

pub contract NFTTradingPlatformContract {
    // Storage variables
    pub var nftsForSale: {UInt64: UFix64}

    // Function to list an NFT for sale
    pub fun listNFTForSale(nftID: UInt64, price: UFix64) {
        // Set the price for the NFT
        self.nftsForSale[nftID] = price
    }

    // Function to remove an NFT from sale
    pub fun removeNFTFromSale(nftID: UInt64) {
        // Remove the NFT from the list of NFTs for sale
        self.nftsForSale.remove(nftID)
    }

    // Function to get the price of an NFT for sale
    pub fun getNFTPrice(nftID: UInt64): UFix64 {
        return self.nftsForSale[nftID] ?? 0.0
    }
}
