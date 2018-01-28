import UIKit

struct Requester {
    func classify(image: UIImage, completion: @escaping ([[String: Any]], Error?) -> Void) {
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
                let json = try! JSONSerialization.jsonObject(with: data!, options: [])

                completion(json as? [[String: Any]] ?? [], error)
            } else {
                completion([], error)
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
}
