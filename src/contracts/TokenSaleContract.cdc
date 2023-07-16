import FungibleToken from 0xFungibleToken

pub contract TokenSaleContract {
    // Reference to the FungibleToken contract
    pub let tokenProvider: Capability<&{FungibleToken.FungibleTokenReceiver}>

    // Storage variables
    pub var tokenSaleActive: Bool
    pub var tokenPrice: UFix64
    pub var tokenSupply: UInt64
    pub var tokensSold: UInt64
    pub var tokenSaleEndTime: UInt64

    // Event emitted when tokens are purchased
    pub event TokensPurchased(
        buyer: Address,
        amount: UInt64,
        totalPrice: UFix64
    )

    // Modifier to check if the token sale is active
    pub fun isActiveSale(): Bool {
        return self.tokenSaleActive && (getCurrentBlockTime() <= self.tokenSaleEndTime)
    }

    // Function to start the token sale
    pub fun startTokenSale(price: UFix64, supply: UInt64, saleDuration: UInt64) {
        pre {
            !self.tokenSaleActive: "Token sale already active"
        }

        self.tokenSaleActive = true
        self.tokenPrice = price
        self.tokenSupply = supply
        self.tokensSold = 0
        self.tokenSaleEndTime = getCurrentBlockTime() + saleDuration
    }

    // Function to purchase tokens
    pub fun purchaseTokens(amount: UInt64) {
        pre {
            self.isActiveSale(): "Token sale is not active"
            amount > 0: "Invalid token amount"
            self.tokensSold + amount <= self.tokenSupply: "Insufficient tokens available for sale"
        }

        let totalPrice = self.tokenPrice * UFix64(amount)

        // Transfer the required payment from the buyer to the contract
        FungibleToken.withdraw(from: <-tokenProvider.borrow()!, amount: totalPrice)
        FungibleToken.deposit(to: self.account, amount: totalPrice)

        // Update the tokens sold count
        self.tokensSold += amount

        // Emit the TokensPurchased event
        emit TokensPurchased(buyer: self.account.address, amount: amount, totalPrice: totalPrice)
    }

    // Function to end the token sale
    pub fun endTokenSale() {
        pre {
            self.tokenSaleActive: "Token sale is not active"
        }

        self.tokenSaleActive = false
    }
}
