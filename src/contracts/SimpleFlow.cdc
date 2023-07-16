import FungibleToken from 0xFungibleToken
import FlowToken from 0xFlowToken

// SimpleFlow contract demonstrating token minting and transfer

pub contract SimpleFlow {
    // Resource representing a token with a balance
    pub resource TRLToken {
        pub var balance: UInt64

        init(balance: UInt64) {
            self.balance = balance
        }
    }

    // Function to mint tokens to a recipient
    pub fun mintTokens(recipient: &TRLToken, amount: UInt64) {
        recipient.balance += amount
    }

    // Function to get the balance of a token holder
    pub fun getBalance(holder: &TRLToken): UInt64 {
        return holder.balance
    }

    // Function to transfer tokens between two accounts
    pub fun transferTokens(from: &TRLToken, to: &TRLToken, amount: UInt64) {
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
