import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "test")!
        Requester().classify(image: image) { (val, err) in
            print(val)
            print(err)
        }
    }

}
