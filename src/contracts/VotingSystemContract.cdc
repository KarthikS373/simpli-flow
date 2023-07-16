pub contract VotingSystemContract {
    // Storage variables
    pub var proposals: {String: UInt64}
    pub var votes: {UInt64: {Address: Bool}}

    // Event emitted when a new proposal is created
    pub event ProposalCreated(String)

    // Event emitted when a vote is cast
    pub event VoteCasted(UInt64)

    // Function to create a new proposal
    pub fun createProposal(proposal: String) {
        // Ensure the proposal does not already exist
        pre {
            !self.proposals.containsKey(proposal): "Proposal already exists"
        }

        self.proposals[proposal] = 0

        // Emit the ProposalCreated event
        emit ProposalCreated(proposal)
    }

    // Function to cast a vote for a proposal
    pub fun castVote(proposal: String) {
        // Ensure the proposal exists
        pre {
            self.proposals.containsKey(proposal): "Proposal does not exist"
        }

        let voteID = self.borrowNextVoteID()

        if !self.votes.containsKey(voteID) {
            self.votes[voteID] = {}
        }

        // Ensure the caller has not already voted
        pre {
            !self.votes[voteID].contains(self.account.address): "Already voted"
        }

        self.votes[voteID][self.account.address] = true

        // Increment the vote count for the proposal
        self.proposals[proposal] += 1

        // Emit the VoteCasted event
        emit VoteCasted(voteID)
    }
}
