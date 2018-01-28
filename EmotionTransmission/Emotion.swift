import Foundation

enum Emotion: String {
    case anger
    case contempt
    case disgust
    case fear
    case happiness
    case neutral
    case sadness
    case surprise

    static func random() -> Emotion {
        let emotions = [
            Emotion.anger.rawValue,
            Emotion.contempt.rawValue,
            Emotion.disgust.rawValue,
            Emotion.fear.rawValue,
            Emotion.happiness.rawValue,
            Emotion.neutral.rawValue,
            Emotion.sadness.rawValue,
            Emotion.surprise.rawValue,
        ]

        let index = Int(arc4random_uniform(UInt32(emotions.count)))

        return Emotion(rawValue: emotions[index])!
    }
}
