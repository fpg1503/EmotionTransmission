import UIKit

struct Requester {
    func classify(image: UIImage, completion: @escaping (EmotionResponse?, Error?) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let url = URL(string: "https://westus.api.cognitive.microsoft.com/emotion/v1.0/recognize")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        request.addValue(Key.API, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.addValue("application/octet-stream", forHTTPHeaderField: "Content-Type")

        let imageData = UIImageJPEGRepresentation(image, 0.8)

        request.httpBody = imageData

        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String: Any]]

                if let firstFace = json.first {
                    let scores = firstFace["scores"] as! [String: Double]
                    let anger = scores[Emotion.anger.rawValue]!
                    let contempt = scores[Emotion.contempt.rawValue]!
                    let disgust = scores[Emotion.disgust.rawValue]!
                    let fear = scores[Emotion.fear.rawValue]!
                    let happiness = scores[Emotion.happiness.rawValue]!
                    let neutral = scores[Emotion.neutral.rawValue]!
                    let sadness = scores[Emotion.sadness.rawValue]!
                    let surprise = scores[Emotion.surprise.rawValue]!

                    let response = EmotionResponse(anger: anger, contempt: contempt, disgust: disgust, fear: fear, happiness: happiness, neutral: neutral, sadness: sadness, surprise: surprise)
                    completion(response, error)
                } else {
                    completion(nil, NSError(domain: "No Faces", code: 123, userInfo: nil))
                }
            } else {
                completion(nil, error)
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
}
