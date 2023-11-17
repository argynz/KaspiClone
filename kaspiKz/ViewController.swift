import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameEditButton: UIButton!
    @IBOutlet weak var noneEdNameLable: UILabel!
    @IBOutlet weak var edNameLable: UILabel!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var edSurnameLable: UILabel!
    @IBOutlet weak var surnameEditButton: UIButton!
    @IBOutlet weak var noneEdSurnameLable: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    var boo = true
    var boo1 = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image.layer.borderWidth = 1
        self.image.layer.borderColor = UIColor.clear.cgColor
        self.image.layer.masksToBounds = false
        self.image.layer.cornerRadius = image.frame.size.height/2
        self.image.clipsToBounds = true
        
        nameTextField.isHidden = true
        surnameTextField.isHidden = true
        
        nameTextField.delegate = self
        surnameTextField.delegate = self
        
        AddGusture()
    }
    
    @IBAction func nameEditButton(_ sender: UIButton) {
        if boo{
            nameEditButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            boo = !boo
        }else{
            nameTextField.endEditing(true)
            nameEditButton.setImage(UIImage(systemName: "pencil"), for: .normal)
            boo = !boo
        }
        noneEdNameLable.isHidden = !noneEdNameLable.isHidden
        edNameLable.isHidden = !edNameLable.isHidden
        nameTextField.isHidden = !nameTextField.isHidden
    }
    
    @IBAction func surnameEditButton(_ sender: UIButton) {
        if boo1{
            surnameEditButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            boo1 = !boo1
        }else{
            surnameTextField.endEditing(true)
            surnameEditButton.setImage(UIImage(systemName: "pencil"), for: .normal)
            boo1 = !boo1
        }
        noneEdSurnameLable.isHidden = !noneEdSurnameLable.isHidden
        edSurnameLable.isHidden = !edSurnameLable.isHidden
        surnameTextField.isHidden = !surnameTextField.isHidden
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let name = textField.text{
            if textField == nameTextField{
                edNameLable.text = name
            }else{
                edSurnameLable.text = name
            }
            
        }
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
