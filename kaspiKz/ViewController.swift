import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image.layer.borderWidth = 1
        self.image.layer.borderColor = UIColor.clear.cgColor
        self.image.layer.masksToBounds = false
        self.image.layer.cornerRadius = image.frame.size.height/2
        self.image.clipsToBounds = true
        
        AddGusture()
    }
    
    func AddGusture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector (ImageTapped))
        self.image.isUserInteractionEnabled = true
        self.image.addGestureRecognizer(tap)
    }
    
    @objc func ImageTapped(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let picking = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        self.image.image = picking
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    }
