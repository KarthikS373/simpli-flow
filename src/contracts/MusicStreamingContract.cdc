pub contract MusicStreamingContract {
    // Storage variables
    pub var songs: {UInt64: String}

    // Function to upload a song
    pub fun uploadSong(songID: UInt64, songURI: String) {
        // Store the URI of the song
        self.songs[songID] = songURI
    }

    // Function to get the URI of a song
    pub fun getSongURI(songID: UInt64): String {
        return self.songs[songID] ?? ""
    }
}
