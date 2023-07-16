import FungibleToken from 0xFungibleToken

pub contract DecentralizedLendingContract {
    // Storage variables
    pub var lenders: {Address: UFix64}
    pub var borrowers: {Address: UFix64}
    pub let tokenProvider: Capability<&{FungibleToken.FungibleTokenReceiver}>

    // Function for lenders to provide a loan
    pub fun provideLoan(amount: UFix64) {
        pre {
            amount > 0.0: "Invalid loan amount"
        }

        let lender = self.account.address

        // Transfer the loan amount from the lender to the contract
        FungibleToken.withdraw(from: <-self.tokenProvider.borrow()!, amount: amount)
        FungibleToken.deposit(to: self.account, amount: amount)

        // Update the lender's loan amount
        self.lenders[lender] += amount
    }

    // Function for borrowers to repay a loan
    pub fun repayLoan(amount: UFix64) {
        let borrower = self.account.address

        // Ensure the borrower has enough loan amount
        pre {
            self.borrowers[borrower] >= amount: "Insufficient loan amount"
        }

        // Transfer the loan amount from the borrower to the contract
        FungibleToken.withdraw(from: self.account, amount: amount)
        FungibleToken.deposit(to: <-self.tokenProvider.borrow()!, amount: amount)

        // Update the borrower's loan amount
        self.borrowers[borrower] -= amount
    }
}
