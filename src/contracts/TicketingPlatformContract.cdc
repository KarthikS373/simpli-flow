pub contract TicketingPlatformContract {
    // Storage variables
    pub var events: {UInt64: [Address]}

    // Function to create an event
    pub fun createEvent(eventID: UInt64, attendees: [Address]) {
        // Store the list of attendees for the event
        self.events[eventID] = attendees
    }

    // Function to cancel an event
    pub fun cancelEvent(eventID: UInt64) {
        // Remove the event from the list of events
        self.events.remove(eventID)
    }

    // Function to get the list of attendees for an event
    pub fun getEventAttendees(eventID: UInt64): [Address] {
        return self.events[eventID] ?? []
    }
}
