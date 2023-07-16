pub contract SubscriptionServiceContract {
    // Storage variables
    pub var subscribers: {Address: UInt64}
    pub let subscriptionPrice: UFix64

    // Event emitted when a new subscription is purchased
    pub event SubscriptionPurchased(Address)

    // Function to purchase a subscription
    pub fun purchaseSubscription() {
        let subscriber = self.account.address

        // Ensure the subscriber does not already have an active subscription
        pre {
            !self.subscribers.containsKey(subscriber): "Already subscribed"
        }

        // Transfer the subscription price from the subscriber to the contract
        FungibleToken.withdraw(from: <-subscriber.load<@FungibleToken.Vault> { 
            available: account.load<@FungibleToken.Vault>(/public/fungibleTokenVault) 
        }!, amount: self.subscriptionPrice)
        FungibleToken.deposit(to: self.account, amount: self.subscriptionPrice)

        // Add the subscriber to the list of subscribers
        self.subscribers[subscriber] = getCurrentBlockTime()

        // Emit the SubscriptionPurchased event
        emit SubscriptionPurchased(subscriber)
    }

    // Function to check if a subscriber has an active subscription
    pub fun hasActiveSubscription(address: Address): Bool {
        return self.subscribers.containsKey(address)
    }
}
