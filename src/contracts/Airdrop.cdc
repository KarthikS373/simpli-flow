import FungibleToken from 0xFungibleToken
import FlowToken from 0xFlowToken

pub contract Airdrop {
    // Reference to the FungibleToken contract
    pub let tokenProvider: Capability<&{FungibleToken.FungibleTokenReceiver}>
    
    // Airdrop function to distribute tokens to a list of recipients
    pub fun airdrop(recipients: [Address], amounts: [UInt64]) {
        // Check the lengths of recipients and amounts arrays
        if recipients.length != amounts.length {
            panic("Mismatch in the number of recipients and amounts")
        }
        
        // Get the balance of the airdrop contract
        let balance = FlowToken.balance<Token>(from: <- tokenProvider.borrow()!)
        
        // Calculate the total token amount to be airdropped
        let totalAmount = amounts.reduce(0, +)
        
        // Ensure the contract has enough tokens to perform the airdrop
        if balance < totalAmount {
            panic("Insufficient balance in the airdrop contract")
        }
        
        // Perform the airdrop
        for i in 0..<recipients.length {
            let recipient = recipients[i]
            let amount = amounts[i]
            
            // Transfer tokens from the airdrop contract to the recipient
            FlowToken.transfer(from: <- tokenProvider.borrow()!, to: recipient, amount: amount)
        }
    }
}
