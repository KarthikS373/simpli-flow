pub contract DecentralizedIdentityContract {
    // Storage variables
    pub var identities: {Address: Identity}

    // Struct representing an identity
    pub struct Identity {
        pub let name: String
        pub let publicKey: String
    }

    // Function to register an identity
    pub fun registerIdentity(name: String, publicKey: String) {
        let identity = Identity(
            name: name,
            publicKey: publicKey
        )

        self.identities[self.account.address] = identity
    }
}
