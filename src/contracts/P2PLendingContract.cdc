pub contract P2PLendingContract {
    // Storage variables
    pub var loans: {UInt64: Address}

    // Function to create a loan
    pub fun createLoan(loanID: UInt64) {
        // Store the borrower's address for the loan
        self.loans[loanID] = self.account.address
    }

    // Function to cancel a loan
    pub fun cancelLoan(loanID: UInt64) {
        // Remove the loan from the list of loans
        self.loans.remove(loanID)
    }

    // Function to get the borrower's address for a loan
    pub fun getLoanBorrower(loanID: UInt64): Address {
        return self.loans[loanID] ?? Address(0)
    }
}
