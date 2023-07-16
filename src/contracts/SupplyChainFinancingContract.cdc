pub contract SupplyChainFinancingContract {
    // Storage variables
    pub var invoices: {UInt64: UFix64}

    // Function to create an invoice
    pub fun createInvoice(invoiceID: UInt64, invoiceAmount: UFix64) {
        // Store the invoice amount for the invoice
        self.invoices[invoiceID] = invoiceAmount
    }

    // Function to cancel an invoice
    pub fun cancelInvoice(invoiceID: UInt64) {
        // Remove the invoice from the list of invoices
        self.invoices.remove(invoiceID)
    }

    // Function to get the invoice amount for an invoice
    pub fun getInvoiceAmount(invoiceID: UInt64): UFix64 {
        return self.invoices[invoiceID] ?? 0.0
    }
}
