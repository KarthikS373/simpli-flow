pub contract RideSharingContract {
    // Storage variables
    pub var rides: {UInt64: Address}

    // Function to request a ride
    pub fun requestRide(rideID: UInt64) {
        // Store the requester's address for the ride
        self.rides[rideID] = self.account.address
    }

    // Function to cancel a ride request
    pub fun cancelRideRequest(rideID: UInt64) {
        // Remove the ride request from the list of rides
        self.rides.remove(rideID)
    }

    // Function to get the requester's address for a ride
    pub fun getRideRequester(rideID: UInt64): Address {
        return self.rides[rideID] ?? Address(0)
    }
}
