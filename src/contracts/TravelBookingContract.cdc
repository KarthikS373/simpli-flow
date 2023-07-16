pub contract TravelBookingContract {
    // Storage variables
    pub var bookings: {UInt64: [Address]}

    // Function to book a travel reservation
    pub fun bookTravelReservation(bookingID: UInt64, travelers: [Address]) {
        // Store the traveler addresses for the booking
        self.bookings[bookingID] = travelers
    }

    // Function to cancel a travel reservation
    pub fun cancelTravelReservation(bookingID: UInt64) {
        // Remove the booking from the list of bookings
        self.bookings.remove(bookingID)
    }

    // Function to get the traveler addresses for a booking
    pub fun getBookingTravelers(bookingID: UInt64): [Address] {
        return self.bookings[bookingID] ?? []
    }
}
