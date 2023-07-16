import FungibleToken from 0xFungibleToken

pub contract GovernanceContract {
    // Storage variables
    pub var proposals: {UInt64: Proposal}
    pub var votes: {UInt64: {Address: Bool}}

    // Struct representing a proposal
    pub struct Proposal {
        pub let creator: Address
        pub let description: String
        pub var votesFor: UFix64
        pub var votesAgainst: UFix64
        pub var isApproved: Bool
    }

    // Event emitted when a new proposal is created
    pub event ProposalCreated(UInt64)

    // Event emitted when a vote is cast
    pub event VoteCasted(UInt64, Address, Bool)

    // Function to create a new proposal
    pub fun createProposal(description: String) {
        let proposalID = /* generate a unique proposal ID */
        let proposal = Proposal(
            creator: self.account.address,
            description: description,
            votesFor: 0.0,
            votesAgainst: 0.0,
            isApproved: false
        )

        self.proposals[proposalID] = proposal

        // Emit the ProposalCreated event
        emit ProposalCreated(proposalID)
    }

    // Function to cast a vote for a proposal
    pub fun castVote(proposalID: UInt64, isApprove: Bool) {
        // Ensure the proposal exists
        let proposal = self.proposals[proposalID]
        pre {
            proposal.creator != Address(0): "Proposal does not exist"
            !proposal.isApproved: "Proposal is already approved"
        }

        // Ensure the caller has not already voted for the proposal
        pre {
            !self.votes[proposalID].contains(self.account.address): "Already voted"
        }

        // Update the vote count for the proposal
        if isApprove {
            proposal.votesFor += 1
        } else {
            proposal.votesAgainst += 1
        }

        // Add the vote to the votes mapping
        self.votes[proposalID][self.account.address] = isApprove

        // Emit the VoteCasted event
        emit VoteCasted(proposalID, self.account.address, isApprove)
    }
}
