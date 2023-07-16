import FungibleToken from 0xFungibleToken

pub contract DecentralizedBorrowingContract {
    // Storage variables
    pub var lenders: {Address: UFix64}
    pub var borrowers: {Address: UFix64}
    pub let tokenProvider: Capability<&{FungibleToken.FungibleTokenReceiver}>

    // Function for lenders to provide funds for borrowing
    pub fun provideFunds(amount: UFix64) {
        pre {
            amount > 0.0: "Invalid fund amount"
        }

        let lender = self.account.address

        // Transfer the fund amount from the lender to the contract
        FungibleToken.withdraw(from: <-self.tokenProvider.borrow()!, amount: amount)
        FungibleToken.deposit(to: self.account, amount: amount)

        // Update the lender's fund amount
        self.lenders[lender] += amount
    }

    // Function for borrowers to borrow funds
    pub fun borrowFunds(amount: UFix64) {
        pre {
            amount > 0.0: "Invalid borrow amount"
        }

        let borrower = self.account.address

        // Ensure the borrower has enough available funds
        pre {
            self.lenders[borrower] >= amount: "Insufficient available funds"
        }

        // Transfer the borrowed amount from the contract to the borrower
        FungibleToken.withdraw(from: self.account, amount: amount)
        FungibleToken.deposit(to: <-self.tokenProvider.borrow()!, amount: amount)

        // Update the borrower's borrowed amount
        self.borrowers[borrower] += amount
    }
}
