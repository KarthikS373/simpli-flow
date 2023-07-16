import FungibleToken from 0xFungibleToken

pub contract CharityDonationsContract {
    // Storage variables
    pub var charityWallet: Address
    pub var totalDonations: UFix64

    // Event emitted when a donation is made
    pub event Donation(Address, UFix64)

    // Function to initialize the charity donations contract
    pub fun init(charityWalletAddress: Address) {
        self.charityWallet = charityWalletAddress
        self.totalDonations = 0.0
    }

    // Function to make a donation to the charity
    pub fun makeDonation(amount: UFix64) {
        // Transfer the donation amount from the caller to the charity wallet
        FungibleToken.withdraw(from: self.account, amount: amount)
        FungibleToken.deposit(to: self.charityWallet, amount: amount)

        // Update the total donations
        self.totalDonations += amount

        // Emit the Donation event
        emit Donation(self.account.address, amount)
    }

    // Function to get the total donations made
    pub fun getTotalDonations(): UFix64 {
        return self.totalDonations
    }
}
