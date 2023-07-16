import NonFungibleToken from 0xNonFungibleToken

pub contract NFTGamingPlatformContract {
    // Storage variables
    pub var gameScores: {UInt64: UInt64}

    // Function to set the score for an NFT in a game
    pub fun setGameScore(nftID: UInt64, score: UInt64) {
        // Set the score for the NFT in the game
        self.gameScores[nftID] = score
    }

    // Function to get the score for an NFT in a game
    pub fun getGameScore(nftID: UInt64): UInt64 {
        return self.gameScores[nftID] ?? 0
    }
}
