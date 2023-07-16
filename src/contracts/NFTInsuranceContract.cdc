import NonFungibleToken from 0xNonFungibleToken

pub contract NFTInsuranceContract {
    // Storage variables
    pub var insuredNFTs: {UInt64: Bool}

    // Function to insure an NFT
    pub fun insureNFT(nftID: UInt64) {
        // Set the insured status for the NFT
        self.insuredNFTs[nftID] = true
    }

    // Function to cancel insurance for an NFT
    pub fun cancelInsurance(nftID: UInt64) {
        // Remove the NFT from the list of insured NFTs
        self.insuredNFTs.remove(nftID)
    }

    // Function to check if an NFT is insured
    pub fun isNFTInsured(nftID: UInt64): Bool {
        return self.insuredNFTs[nftID] ?? false
    }
}
