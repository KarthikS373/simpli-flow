pub contract JobBoardContract {
    // Storage variables
    pub var jobPostings: {UInt64: String}

    // Function to post a job
    pub fun postJob(jobID: UInt64, jobDescription: String) {
        // Store the job description for the job posting
        self.jobPostings[jobID] = jobDescription
    }

    // Function to remove a job posting
    pub fun removeJobPosting(jobID: UInt64) {
        // Remove the job posting from the list of job postings
        self.jobPostings.remove(jobID)
    }

    // Function to get the job description for a job posting
    pub fun getJobDescription(jobID: UInt64): String {
        return self.jobPostings[jobID] ?? ""
    }
}
