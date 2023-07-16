pub contract DecentralizedPredictionMarketContract {
    // Storage variables
    pub var predictions: {String: Prediction}

    // Struct representing a prediction
    pub struct Prediction {
        pub let creator: Address
        pub let description: String
        pub var votesFor: UInt64
        pub var votesAgainst: UInt64
        pub var isResolved: Bool
        pub var outcome: Bool?
    }

    // Event emitted when a new prediction is created
    pub event PredictionCreated(String)

    // Function to create a new prediction
    pub fun createPrediction(description: String) {
        let prediction = Prediction(
            creator: self.account.address,
            description: description,
            votesFor: 0,
            votesAgainst: 0,
            isResolved: false,
            outcome: nil
        )

        self.predictions[description] = prediction

        // Emit the PredictionCreated event
        emit PredictionCreated(description)
    }

    // Function to vote on a prediction
    pub fun voteOnPrediction(description: String, isApprove: Bool) {
        let prediction = self.predictions[description]

        // Ensure the prediction exists and is not resolved
        pre {
            prediction.creator != Address(0): "Prediction does not exist"
            !prediction.isResolved: "Prediction is resolved"
        }

        // Update the vote count for the prediction
        if isApprove {
            prediction.votesFor += 1
        } else {
            prediction.votesAgainst += 1
        }
    }

    // Function to resolve a prediction
    pub fun resolvePrediction(description: String, outcome: Bool) {
        let prediction = self.predictions[description]

        // Ensure the prediction exists and is not already resolved
        pre {
            prediction.creator != Address(0): "Prediction does not exist"
            !prediction.isResolved: "Prediction is already resolved"
        }

        // Update the prediction with the outcome
        prediction.isResolved = true
        prediction.outcome = outcome
    }
}
