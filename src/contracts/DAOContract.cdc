import FungibleToken from 0xFungibleToken

pub contract DAOContract {
    // Storage variables
    pub var members: {Address: Bool}
    pub var proposals: {UInt64: Proposal}

    // Struct representing a proposal
    pub struct Proposal {
        pub let creator: Address
        pub let description: String
        pub var votes: {Address: Bool}
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
            votes: {},
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

        // Ensure the caller is a member of the DAO
        pre {
            self.members.contains(self.account.address): "Unauthorized"
        }

        // Update the vote for the proposal
        proposal.votes[self.account.address] = isApprove

        // Emit the VoteCasted event
        emit VoteCasted(proposalID, self.account.address, isApprove)
    }

    // Function to calculate the total votes for a proposal
    pub fun calculateTotalVotes(proposalID: UInt64): UInt64 {
        let proposal = self.proposals[proposalID]
        var totalVotes: UInt64 = 0

        for vote in proposal.votes.values {
            if vote {
                totalVotes += 1
            } else {
                totalVotes -= 1
            }
        }

        return totalVotes
    }

    // Function to determine if a proposal is approved
    pub fun isProposalApproved(proposalID: UInt64): Bool {
        let proposal = self.proposals[proposalID]
        let totalVotes = self.calculateTotalVotes(proposalID)

        return totalVotes > 0 && totalVotes >= UInt64(self.members.length / 2)
    }
}
