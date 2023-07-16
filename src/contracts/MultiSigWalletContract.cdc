pub contract MultiSigWalletContract {
    // Storage variables
    pub var owners: {Address: Bool}
    pub var requiredSignatures: UInt8
    pub var transactions: {UInt64: Transaction}

    // Struct representing a transaction
    pub struct Transaction {
        pub let to: Address
        pub let value: UFix64
        pub var signatures: {Address: Bool}
        pub var isExecuted: Bool
    }

    // Event emitted when a transaction is created
    pub event TransactionCreated(
        id: UInt64,
        to: Address,
        value: UFix64
    )

    // Event emitted when a transaction is executed
    pub event TransactionExecuted(UInt64)

    // Function to create a new transaction
    pub fun createTransaction(to: Address, value: UFix64) {
        // Ensure the caller is one of the owners
        pre {
            self.owners.contains(self.account.address): "Unauthorized"
        }

        let transactionID = self.borrowNextTransactionID()
        let transaction = Transaction(
            to: to,
            value: value,
            signatures: {},
            isExecuted: false
        )

        self.transactions[transactionID] = transaction

        // Emit the TransactionCreated event
        emit TransactionCreated(id: transactionID, to: to, value: value)
    }

    // Function to sign a transaction
    pub fun signTransaction(transactionID: UInt64) {
        // Ensure the caller is one of the owners
        pre {
            self.owners.contains(self.account.address): "Unauthorized"
        }

        // Ensure the transaction exists and is not executed
        let transaction = self.transactions[transactionID]
        pre {
            transaction.to != Address(0): "Transaction does not exist"
            !transaction.isExecuted: "Transaction already executed"
        }

        // Add the signature to the transaction
        transaction.signatures[self.account.address] = true
    }

    // Function to execute a transaction
    pub fun executeTransaction(transactionID: UInt64) {
        // Ensure the transaction exists and is not executed
        let transaction = self.transactions[transactionID]
        pre {
            transaction.to != Address(0): "Transaction does not exist"
            !transaction.isExecuted: "Transaction already executed"
            Object.keys(transaction.signatures).length >= self.requiredSignatures: "Insufficient signatures"
        }

        // Execute the transaction
        // ...

        // Mark the transaction as executed
        transaction.isExecuted = true

        // Emit the TransactionExecuted event
        emit TransactionExecuted(transactionID)
    }
}
