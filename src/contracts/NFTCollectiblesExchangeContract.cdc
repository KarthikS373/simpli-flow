import NonFungibleToken from 0xNonFungibleToken

pub contract NFTCollectiblesExchangeContract {
    // Storage variables
    pub var nftsForTrade: {UInt64: [Address]}

    // Function to list NFTs for trade
    pub fun listNFTsForTrade(nftIDs: [UInt64], traders: [Address]) {
        // Associate NFTs with traders for trading
        for i in 0..<nftIDs.length {
            let nftID = nftIDs[i]
            let trader = traders[i]

            if let nftOwners = self.nftsForTrade[nftID] {
                self.nftsForTrade[nftID] = nftOwners.append(trader)
            } else {
                self.nftsForTrade[nftID] = [trader]
            }
        }
    }

    // Function to remove NFTs from trade
    pub fun removeNFTsFromTrade(nftIDs: [UInt64], traders: [Address]) {
        // Remove NFTs from the list of NFTs for trade
        for i in 0..<nftIDs.length {
            let nftID = nftIDs[i]
            let trader = traders[i]

            if let nftOwners = self.nftsForTrade[nftID] {
                self.nftsForTrade[nftID] = nftOwners.remove(trader)
            }
        }
    }

    // Function to get traders for an NFT
    pub fun getNFTTraders(nftID: UInt64): [Address] {
        return self.nftsForTrade[nftID] ?? []
    }
}
