import FungibleToken from 0xFungibleToken

pub contract TokenizedEnergyTradingContract {
    // Storage variables
    pub var energyTokens: {String: UFix64}

    // Function to mint energy tokens
    pub fun mintEnergyTokens(tokenID: String, amount: UFix64) {
        pre {
            amount > 0.0: "Invalid token amount"
        }

        // Mint new energy tokens
        self.energyTokens[tokenID] += amount
    }

    // Function to transfer energy tokens
    pub fun transferEnergyTokens(tokenID: String, amount: UFix64, recipient: Address) {
        pre {
            amount > 0.0: "Invalid token amount"
        }

        // Transfer energy tokens from the caller to the recipient
        self.energyTokens[tokenID] -= amount
        self.energyTokens[tokenID][recipient] += amount
    }
}
