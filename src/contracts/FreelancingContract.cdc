pub contract FreelancingContract {
    // Storage variables
    pub var client: Address
    pub var freelancer: Address
    pub var projectDescription: String
    pub var projectDeadline: String
    pub var projectAmount: UFix64
    pub var isCompleted: Bool

    // Event emitted when the project is completed
    pub event ProjectCompleted()

    // Function to initialize the contract
    init(clientAddress: Address, freelancerAddress: Address, description: String, deadline: String, amount: UFix64) {
        self.client = clientAddress
        self.freelancer = freelancerAddress
        self.projectDescription = description
        self.projectDeadline = deadline
        self.projectAmount = amount
        self.isCompleted = false
    }

    // Function to mark the project as completed
    pub fun completeProject() {
        // Ensure the caller is the freelancer
        pre {
            self.account.address == self.freelancer: "Unauthorized"
        }

        // Mark the project as completed
        self.isCompleted = true

        // Emit the ProjectCompleted event
        emit ProjectCompleted()
    }
}
