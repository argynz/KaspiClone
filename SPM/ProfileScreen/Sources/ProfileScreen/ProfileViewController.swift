import UIKit
import NetworkManager

public class ProfileViewController: UIViewController{
    
    private var profilePageView: ProfilePageView?
    private let networkManager = NetworkManagerImpl()
    
    let userDefaults = UserDefaults.standard
    var uuid = UUID()
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        profilePageView = ProfilePageView()
        profilePageView?.setupUI(view)
        
        profilePageView?.nameTextField.delegate = self
        profilePageView?.surnameTextField.delegate = self
        
        profilePageView?.nameEditButton.addTarget(nil, action: #selector(nameEditButton), for: .touchUpInside)
        profilePageView?.surnameEditButton.addTarget(nil, action: #selector(surnameEditButton), for: .touchUpInside)
        profilePageView?.randomImgButton.addTarget(nil, action: #selector(randomImgButtonPressed), for: .touchUpInside)
        AddGustures()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let profileImageView = profilePageView?.profileImageView {
                profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
            }
    }
    
    @objc func nameEditButton(_ sender: UIButton) {
        if let contentView = profilePageView {
            handleEditButton(textField: contentView.nameTextField, button: sender)
            contentView.noneEditableNameLabel.isHidden.toggle()
            contentView.editableNameLabel.isHidden.toggle()
        }
        
    }

    @objc func surnameEditButton(_ sender: UIButton) {
        if let contentView = profilePageView {
            handleEditButton(textField: contentView.surnameTextField, button: sender)
            contentView.noneEditableSurnameLabel.isHidden.toggle()
            contentView.editableSurnameLabel.isHidden.toggle()
        }
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
    
    func AddGustures(){
        let tap = UITapGestureRecognizer(target: self, action: #selector (ImageTapped))
        profilePageView?.profileImageView.addGestureRecognizer(tap)
    }
    
    @objc func ImageTapped(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }

    @objc func randomImgButtonPressed(_ sender: UIButton) {
        
        profilePageView?.profileImageView.isHidden = true
        profilePageView?.loadingIndicator.isHidden = false
        profilePageView?.loadingIndicator.startAnimating()
        
        let currentUuid = UUID()
        self.uuid = currentUuid
        
        networkManager.fetchRandomImage { [weak self] image, error in
            DispatchQueue.main.async {
                guard let self, self.uuid == currentUuid else { return }
                
                if let image = image {
                    self.profilePageView?.profileImageView.image = image
                    if let imageData = image.pngData() {
                        self.userDefaults.set(imageData, forKey: "PhotoData")
                    }
                    self.profilePageView?.profileImageView.isHidden = false
                }
                
                self.profilePageView?.loadingIndicator.stopAnimating()
                self.profilePageView?.loadingIndicator.isHidden = true
                
                if let error = error {
                    print(error)
                }
            }
        }
    }
}

extension ProfileViewController: UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let name = textField.text{
            if textField == profilePageView?.nameTextField{
                profilePageView?.editableNameLabel.text = name
                userDefaults.setValue(name, forKey: "Name")
            }else{
                profilePageView?.editableSurnameLabel.text = name
                userDefaults.setValue(name, forKey: "Surname")
            }
        }
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let picking = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        profilePageView?.profileImageView.image = picking
        userDefaults.set(picking?.pngData(), forKey: "PhotoData")
        
        picker.dismiss(animated: true)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
