import NonFungibleToken from 0xNonFungibleToken

pub contract NFTLendingContract {
    // Storage variables
    pub var nftLoans: {UInt64: Address}

    // Function to lend an NFT
    pub fun lendNFT(nftID: UInt64, borrower: Address) {
        // Set the borrower for the lent NFT
        self.nftLoans[nftID] = borrower
    }

    // Function to return a borrowed NFT
    pub fun returnNFT(nftID: UInt64) {
        // Remove the NFT from the list of lent NFTs
        self.nftLoans.remove(nftID)
    }

    // Function to check if an NFT is currently lent
    pub fun isNFTLent(nftID: UInt64): Bool {
        return self.nftLoans[nftID] != nil
    }
}
