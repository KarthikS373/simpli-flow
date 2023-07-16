pub contract HealthcareServicesContract {
    // Storage variables
    pub var appointments: {UInt64: Address}

    // Function to schedule an appointment
    pub fun scheduleAppointment(appointmentID: UInt64) {
        // Store the patient's address for the appointment
        self.appointments[appointmentID] = self.account.address
    }

    // Function to cancel an appointment
    pub fun cancelAppointment(appointmentID: UInt64) {
        // Remove the appointment from the list of appointments
        self.appointments.remove(appointmentID)
    }

    // Function to get the patient's address for an appointment
    pub fun getAppointmentPatient(appointmentID: UInt64): Address {
        return self.appointments[appointmentID] ?? Address(0)
    }
}
