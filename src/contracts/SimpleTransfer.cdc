// SimpleTransfer contract for token transfers between two accounts

pub contract SimpleTransfer {
    // Resource representing a token with a balance
    pub resource TRLToken {
        pub var balance: UInt64

        init(balance: UInt64) {
            self.balance = balance
        }
    }

    // Function to transfer tokens from one account to another
    pub fun transfer(from: &TRLToken, to: &TRLToken, amount: UInt64) {
        pre {
            amount <= from.balance: "Insufficient balance"
        }
        post {
            from.balance == old(from.balance) - amount: "Transfer from failed"
            to.balance == old(to.balance) + amount: "Transfer to failed"
        }

        // Deduct tokens from the sender's balance
        from.balance -= amount

        // Add tokens to the receiver's balance
        to.balance += amount
    }
}
