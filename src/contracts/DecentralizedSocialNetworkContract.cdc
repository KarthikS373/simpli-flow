pub contract DecentralizedSocialNetworkContract {
    // Storage variables
    pub var profiles: {Address: Profile}

    // Struct representing a profile
    pub struct Profile {
        pub let name: String
        pub let bio: String
        pub let followers: [Address]
    }

    // Function to create a profile
    pub fun createProfile(name: String, bio: String) {
        let profile = Profile(
            name: name,
            bio: bio,
            followers: []
        )

        self.profiles[self.account.address] = profile
    }

    // Function to follow a profile
    pub fun followProfile(profile: Address) {
        let follower = self.account.address

        // Update the followers of the profile
        self.profiles[profile].followers.append(follower)
    }

    // Function to get a profile's followers
    pub fun getFollowers(profile: Address): [Address] {
        return self.profiles[profile].followers
    }
}
