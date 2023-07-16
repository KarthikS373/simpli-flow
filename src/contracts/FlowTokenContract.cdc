import FungibleToken from 0xFungibleToken

pub contract FlowToken: FungibleToken.Contract {
    // Event emitted when tokens are minted
    pub event TokensMinted(
        recipient: Address,
        amount: UFix64
    )

    // Event emitted when tokens are burned
    pub event TokensBurned(
        owner: Address,
        amount: UFix64
    )

    // Initialize the contract
    init() {
        // Set the initial supply of tokens
        self.init(metadata: {})
    }

    // Function to mint new tokens
    pub fun mintTokens(recipient: Address, amount: UFix64) {
        self.mintTokens(recipient, amount)

        // Emit the TokensMinted event
        emit TokensMinted(recipient: recipient, amount: amount)
    }

    // Function to burn tokens
    pub fun burnTokens(amount: UFix64) {
        self.burnTokens(amount)

        // Emit the TokensBurned event
        emit TokensBurned(owner: self.account.address, amount: amount)
    }
}
