struct EmotionResponse {
    let anger: Double
    let contempt: Double
    let disgust: Double
    let fear: Double
    let happiness: Double
    let neutral: Double
    let sadness: Double
    let surprise: Double

    func strongestEmotion() -> Emotion {
        let emotions: [Emotion: Double] = [
            .anger: anger,
            .contempt: contempt,
            .disgust: disgust,
            .fear: fear,
            .happiness: happiness,
            .neutral: neutral,
            .sadness: sadness,
            .surprise: surprise
        ]

        let sorted = emotions.sorted { lhs, rhs -> Bool in
            lhs.value > rhs.value
        }

        print(sorted)
        return sorted.first!.key
    }
}
