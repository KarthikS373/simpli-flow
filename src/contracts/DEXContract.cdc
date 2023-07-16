import FungibleToken from 0xFungibleToken

pub contract DEXContract {
    // Storage variables
    pub var tokenPair: {FungibleToken.NFT: FungibleToken.NFT}
    pub var reserves: {FungibleToken.NFT: {Address: UFix64}}
    pub var tokenProvider: Capability<&{FungibleToken.Provider}>
    pub let feePercentage: UFix64

    // Event emitted when a trade occurs
    pub event TradeExecuted(FungibleToken.NFT, UFix64, FungibleToken.NFT, UFix64)

    // Function to create a new token pair
    pub fun createTokenPair(tokenA: FungibleToken.NFT, tokenB: FungibleToken.NFT) {
        pre {
            !self.tokenPair.containsKey(tokenA): "Token pair already exists"
        }

        self.tokenPair[tokenA] = tokenB
        self.reserves[tokenA] = {}
        self.reserves[tokenB] = {}
    }

    // Function to execute a trade
    pub fun executeTrade(tokenIn: FungibleToken.NFT, amountIn: UFix64, tokenOut: FungibleToken.NFT) {
        let reserveIn = self.reserves[tokenIn]
        let reserveOut = self.reserves[tokenOut]

        pre {
            self.tokenPair[tokenIn] == tokenOut: "Invalid token pair"
            reserveIn.containsKey(self.account.address): "Insufficient funds"
        }

        let amountOut = self.calculateAmountOut(amountIn, reserveIn[tokenIn], reserveOut[tokenOut])

        let fee = amountIn * self.feePercentage
        let amountOutAfterFee = amountOut - fee

        // Update reserves
        reserveIn[tokenIn] -= amountIn
        reserveOut[tokenOut] += amountOutAfterFee

        // Transfer tokens
        FungibleToken.withdraw(from: <-self.tokenProvider.borrow()!, amount: amountIn)
        FungibleToken.deposit(to: self.account, amount: amountOutAfterFee)

        // Emit the TradeExecuted event
        emit TradeExecuted(tokenIn, amountIn, tokenOut, amountOutAfterFee)
    }

    // Function to calculate the amount out for a trade
    pub fun calculateAmountOut(amountIn: UFix64, reserveIn: UFix64, reserveOut: UFix64): UFix64 {
        pre {
            reserveIn > 0.0: "Invalid reserve"
        }

        let amountInWithFee = amountIn * (UFix64(1.0) - self.feePercentage)
        let numerator = amountInWithFee * reserveOut
        let denominator = reserveIn + amountInWithFee
        return numerator / denominator
    }
}
