pub contract ServiceAccountContract {
    // Reference to the service account
    pub let serviceAccount: Capability<&{YOUR_SERVICE_ACCOUNT_TYPE}>

    // Function to perform an action on behalf of the service account
    pub fun performAction(data: String) {
        // Verify that the caller is the service account
        let caller = getAccount(self.account).address
        let serviceAccountAddress = self.serviceAccount.borrow()!.address

        pre {
            caller == serviceAccountAddress: "Unauthorized"
        }

        // Perform the desired action
        // ...
    }
}
