pub contract DecentralizedMessagingContract {
    // Storage variables
    pub var messages: {Address: [String]}

    // Function to send a message
    pub fun sendMessage(recipient: Address, message: String) {
        if let recipientMessages = self.messages[recipient] {
            self.messages[recipient] = recipientMessages.append(message)
        } else {
            self.messages[recipient] = [message]
        }
    }

    // Function to retrieve messages
    pub fun retrieveMessages(): [String] {
        return self.messages[self.account.address] ?? []
    }
}
