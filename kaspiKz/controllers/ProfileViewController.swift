import UIKit

class ProfileViewController: UIViewController{
    
    private var profileViewContent: ProfileViewContent!
    
    let userDefaults = UserDefaults.standard
    var uuid = UUID()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileViewContent = ProfileViewContent()
        profileViewContent.setupUI(view)
        
        profileViewContent.nameTextField.delegate = self
        profileViewContent.surnameTextField.delegate = self
        
        profileViewContent.nameEditButton.addTarget(nil, action: #selector(nameEditButton), for: .touchUpInside)
        profileViewContent.surnameEditButton.addTarget(nil, action: #selector(surnameEditButton), for: .touchUpInside)
        profileViewContent.randomImgButton.addTarget(nil, action: #selector(randomImgButtonPressed), for: .touchUpInside)
        AddGusture()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileViewContent.profileImageView.layer.cornerRadius = profileViewContent.profileImageView.frame.size.height / 2
    }
    
    @objc func nameEditButton(_ sender: UIButton) {
        handleEditButton(textField: profileViewContent.nameTextField, button: sender)
        profileViewContent.noneEditableNameLabel.isHidden = !profileViewContent.noneEditableNameLabel.isHidden
        profileViewContent.editableNameLabel.isHidden = !profileViewContent.editableNameLabel.isHidden
    }

    @objc func surnameEditButton(_ sender: UIButton) {
        handleEditButton(textField: profileViewContent.surnameTextField, button: sender)
        profileViewContent.noneEditableSurnameLabel.isHidden = !profileViewContent.noneEditableSurnameLabel.isHidden
        profileViewContent.editableSurnameLabel.isHidden = !profileViewContent.editableSurnameLabel.isHidden
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
        profileViewContent.profileImageView.addGestureRecognizer(tap)
    }
    
    @objc func ImageTapped(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }

    @objc func randomImgButtonPressed(_ sender: UIButton) {
        
        profileViewContent.profileImageView.isHidden = true
        profileViewContent.loadingIndicator.isHidden = false
        profileViewContent.loadingIndicator.startAnimating()
        
        let currentUuid = UUID()
        self.uuid = currentUuid
        
        NetworkManager.shared.fetchRandomImage { [weak self] image, error in
            DispatchQueue.main.async {
                guard let self = self, self.uuid == currentUuid else { return }
                
                if let image = image {
                    self.profileViewContent.profileImageView.image = image
                    if let imageData = image.pngData() {
                        self.userDefaults.set(imageData, forKey: "PhotoData")
                    }
                    self.profileViewContent.profileImageView.isHidden = false
                }
                
                self.profileViewContent.loadingIndicator.stopAnimating()
                self.profileViewContent.loadingIndicator.isHidden = true
                
                if let error = error {
                    print(error)
                }
            }
        }
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let name = textField.text{
            if textField == profileViewContent.nameTextField{
                profileViewContent.editableNameLabel.text = name
                userDefaults.setValue(name, forKey: "Name")
            }else{
                profileViewContent.editableSurnameLabel.text = name
                userDefaults.setValue(name, forKey: "Surname")
            }
        }
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let picking = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        profileViewContent.profileImageView.image = picking
        userDefaults.set(picking?.pngData(), forKey: "PhotoData")
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}