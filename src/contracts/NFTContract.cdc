import NonFungibleToken from 0xNonFungibleToken

pub contract NFTContract: NonFungibleToken.Contract {
    // Struct representing the data for an NFT
    pub struct NFTData: NonFungibleToken.Token {
        pub var metadata: {String: String}
    }

    // Event emitted when a new NFT is minted
    pub event NFTMinted(
        id: UInt64,
        recipient: Address,
        metadata: {String: String}
    )

    // Function to mint a new NFT
    pub fun mintNFT(recipient: Address, metadata: {String: String}): UInt64 {
        let tokenID: UInt64 = self.borrowNextTokenID()
        let newNFT <- create NFTData()
        newNFT.metadata = metadata
        self.save(<-newNFT, id: tokenID, recipient: recipient)

        // Emit the NFTMinted event
        emit NFTMinted(id: tokenID, recipient: recipient, metadata: metadata)

        return tokenID
    }

    // Function to transfer an NFT from one address to another
    pub fun transferNFT(tokenID: UInt64, to: Address) {
        self.send(tokenID, to: to)
    }

    // Function to get the metadata of an NFT
    pub fun getMetadata(tokenID: UInt64): {String: String} {
        let token = self.borrowNFT(id: tokenID)
        return token.metadata
    }
}
