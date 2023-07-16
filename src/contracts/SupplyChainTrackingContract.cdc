pub contract SupplyChainTrackingContract {
    // Storage variables
    pub var products: {UInt64: Product}

    // Struct representing a product
    pub struct Product {
        pub let creator: Address
        pub let name: String
        pub let trackingHistory: [String]
    }

    // Event emitted when a new product is created
    pub event ProductCreated(UInt64)

    // Event emitted when the product tracking is updated
    pub event ProductTrackingUpdated(UInt64, String)

    // Function to create a new product
    pub fun createProduct(name: String) {
        let productID = /* generate a unique product ID */
        let product = Product(
            creator: self.account.address,
            name: name,
            trackingHistory: []
        )

        self.products[productID] = product

        // Emit the ProductCreated event
        emit ProductCreated(productID)
    }

    // Function to update the tracking history of a product
    pub fun updateProductTracking(productID: UInt64, trackingInfo: String) {
        // Ensure the product exists
        let product = self.products[productID]
        pre {
            product.creator != Address(0): "Product does not exist"
        }

        // Update the tracking history
        product.trackingHistory.append(trackingInfo)

        // Emit the ProductTrackingUpdated event
        emit ProductTrackingUpdated(productID, trackingInfo)
    }
}
