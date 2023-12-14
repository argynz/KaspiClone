import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameEditButton: UIButton!
    @IBOutlet weak var noneEdNameLable: UILabel!
    @IBOutlet weak var edNameLable: UILabel!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var edSurnameLable: UILabel!
    @IBOutlet weak var surnameEditButton: UIButton!
    @IBOutlet weak var noneEdSurnameLable: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameTextField: UITextField!
    
    let userDefaults = UserDefaults.standard
    var uuid = UUID()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImageView.layer.borderWidth = 1
        self.profileImageView.layer.borderColor = UIColor.clear.cgColor
        self.profileImageView.layer.masksToBounds = false
        self.profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2
        self.profileImageView.clipsToBounds = true
        
        nameTextField.isHidden = true
        surnameTextField.isHidden = true
        loadingIndicator.isHidden = true
        
        nameTextField.text = userDefaults.string(forKey: "Name")
        surnameTextField.text = userDefaults.string(forKey: "Surname")
        
        edNameLable.text = userDefaults.string(forKey: "Name")
        edSurnameLable.text = userDefaults.string(forKey: "Surname")
        
        profileImageView.image = UIImage(data: (userDefaults.data(forKey: "PhotoData") ?? UIImage(named: "Icon")?.pngData())!)
        
        nameTextField.delegate = self
        surnameTextField.delegate = self
        
        AddGusture()
    }
    
    @IBAction func nameEditButton(_ sender: UIButton) {
        handleEditButton(textField: nameTextField, button: sender)
        noneEdNameLable.isHidden = !noneEdNameLable.isHidden
        edNameLable.isHidden = !edNameLable.isHidden
    }

    @IBAction func surnameEditButton(_ sender: UIButton) {
        handleEditButton(textField: surnameTextField, button: sender)
        noneEdSurnameLable.isHidden = !noneEdSurnameLable.isHidden
        edSurnameLable.isHidden = !edSurnameLable.isHidden
    }

    private func handleEditButton(textField: UITextField, button: UIButton) {
        if !textField.isFirstResponder {
            textField.becomeFirstResponder()
            button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        } else {
            textField.endEditing(true)
            button.setImage(UIImage(systemName: "pencil"), for: .normal)
        }
        textField.isHidden = !textField.isHidden
    }
    
    func AddGusture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector (ImageTapped))
        self.profileImageView.isUserInteractionEnabled = true
        self.profileImageView.addGestureRecognizer(tap)
    }
    
    @objc func ImageTapped(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }

    @IBAction func RandomButtonPressed(_ sender: UIButton) {
        
        self.profileImageView.isHidden = true
        self.loadingIndicator.isHidden = false
        self.loadingIndicator.startAnimating()
        
        let url = URL(string: "https://api.unsplash.com/photos/random?client_id=OKZnWHhzHPBYwvpYXa2CZmhYePGgufl_4QgiDOb3Obo&orientation=squarish")
        
        let uuid = UUID()
        self.uuid = uuid
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            let decoder = JSONDecoder()
            
            if let data = data {
                do {
                    let tasks = try decoder.decode(photoLink.self, from: data)
                    if let url = NSURL(string: tasks.urls.thumb) {
                        if let data = NSData(contentsOf: url as URL) {
                            DispatchQueue.main.async {
                                if self.uuid == uuid {
                                    self.profileImageView.image = UIImage(data: data as Data)
                                    self.userDefaults.set(data, forKey: "PhotoData")
                                    self.profileImageView.isHidden = false
                                }
                                self.loadingIndicator.stopAnimating()
                                self.loadingIndicator.isHidden = true
                            }
                        }
                    }
                } catch {
                    print(error)
                    
                    DispatchQueue.main.async {
                        self.loadingIndicator.isHidden = true
                        self.loadingIndicator.stopAnimating()
                    }
                }
            }
        }
        task.resume()
    }
    @IBAction func transferButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "SegueToTransfer", sender: self)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let name = textField.text{
            if textField == nameTextField{
                edNameLable.text = name
                userDefaults.setValue(name, forKey: "Name")
            }else{
                edSurnameLable.text = name
                userDefaults.setValue(name, forKey: "Surname")
            }
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let picking = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        self.profileImageView.image = picking
        userDefaults.set(picking?.pngData(), forKey: "PhotoData")
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
