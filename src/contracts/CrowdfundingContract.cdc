import FungibleToken from 0xFungibleToken

pub contract CrowdfundingContract {
    // Storage variables
    pub var creator: Address
    pub var projectDescription: String
    pub var targetAmount: UFix64
    pub var currentAmount: UFix64
    pub var isFundingComplete: Bool
    pub var contributors: {Address: UFix64}
    pub let tokenProvider: Capability<&{FungibleToken.FungibleTokenReceiver}>

    // Event emitted when a contribution is made
    pub event ContributionMade(Address, UFix64)

    // Event emitted when the funding is complete
    pub event FundingComplete()

    // Function to initialize the contract
    init(creatorAddress: Address, description: String, target: UFix64) {
        self.creator = creatorAddress
        self.projectDescription = description
        self.targetAmount = target
        self.currentAmount = 0.0
        self.isFundingComplete = false
        self.contributors = {}
    }

    // Function to contribute funds
    pub fun contribute() {
        let contributor = self.account.address
        let balance = FungibleToken.balance<Token>(from: <-self.tokenProvider.borrow()!)

        pre {
            balance > 0.0: "Insufficient balance"
            !self.isFundingComplete: "Funding is already complete"
        }

        let contributionAmount = balance

        // Add the contribution to the current amount
        self.currentAmount += contributionAmount

        // Update the contributor's contribution amount
        self.contributors[contributor] += contributionAmount

        // Emit the ContributionMade event
        emit ContributionMade(contributor, contributionAmount)
    }

    // Function to check if the funding goal is reached
    pub fun isFundingGoalReached(): Bool {
        return self.currentAmount >= self.targetAmount
    }

    // Function to complete the funding and transfer funds to the creator
    pub fun completeFunding() {
        pre {
            self.creator == self.account.address: "Unauthorized"
            self.isFundingGoalReached(): "Funding goal not reached"
        }

        // Transfer the funds to the creator
        FungibleToken.withdraw(from: <-self.tokenProvider.borrow()!, amount: self.currentAmount)
        FungibleToken.deposit(to: self.creator, amount: self.currentAmount)

        self.isFundingComplete = true

        // Emit the FundingComplete event
        emit FundingComplete()
    }
}
