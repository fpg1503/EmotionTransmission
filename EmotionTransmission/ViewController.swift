import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageVIew: UIImageView!
    @IBOutlet var target: UILabel!
    @IBOutlet var status: UILabel!

    var currentEmotion: Emotion?

    func newEmotion() {
        imageVIew.image = nil
        currentEmotion = Emotion.random()
        target.text = "Target: " + currentEmotion!.rawValue
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        newEmotion()
    }

    @IBAction func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    @IBAction func tryAgain(sender: AnyObject) {
        newEmotion()
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageVIew.image = image
        status.text = "Processing..."
        Requester().classify(image: image) { (response, error) in
            let strongest = response!.strongestEmotion()
            DispatchQueue.main.async {
                if strongest == self.currentEmotion {
                    self.status.text = "Good job!"
                } else {
                    self.status.text = "You got " + strongest.rawValue
                }
            }
        }
        dismiss(animated:true, completion: nil)
    }
    
}
