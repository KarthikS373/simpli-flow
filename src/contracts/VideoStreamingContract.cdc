pub contract VideoStreamingContract {
    // Storage variables
    pub var videos: {UInt64: String}

    // Function to upload a video
    pub fun uploadVideo(videoID: UInt64, videoURI: String) {
        // Store the URI of the video
        self.videos[videoID] = videoURI
    }

    // Function to get the URI of a video
    pub fun getVideoURI(videoID: UInt64): String {
        return self.videos[videoID] ?? ""
    }
}
