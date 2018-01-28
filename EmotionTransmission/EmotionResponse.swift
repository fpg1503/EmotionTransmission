struct EmotionResponse {
    let anger: Float
    let contempt: Float
    let disgust: Float
    let fear: Float
    let neutral: Float
    let sadness: Float
    let surprise: Float

    func strongestEmotion() -> Emotion {
        let emotions: [Emotion: Float] = [
            .anger: anger,
            .contempt: contempt,
            .disgust: disgust,
            .fear: fear,
            .neutral: neutral,
            .sadness: sadness,
            .surprise: surprise
        ]

        let sorted = emotions.sorted { lhs, rhs -> Bool in
            lhs.value < rhs.value
        }

        print(sorted)
        return sorted.first!.key
    }
}
