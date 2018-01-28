import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "test")!
        Requester().classify(image: image) { (val, err) in
            dump(val)
            print(val?.strongestEmotion())
            print(err)
        }
    }

}
