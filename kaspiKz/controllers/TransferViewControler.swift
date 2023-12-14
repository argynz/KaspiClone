import UIKit
import Contacts
import ContactsUI

class TransferViewControler: UIViewController{
    @IBOutlet weak var confirmationButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var resiverView: UIView!
    @IBOutlet weak var resiverNameLabel: UILabel!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var resiverNumberTextField: UITextField!
    @IBOutlet weak var moneyTextFieldsView: UIView!
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var phoneErrorLabel: UILabel!
    @IBOutlet weak var moneyErrorLabel: UILabel!
    @IBOutlet weak var messageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var profilePhotoTopCT: NSLayoutConstraint!
    @IBOutlet weak var messageTopCT: NSLayoutConstraint!
    @IBOutlet weak var moneyTopCT: NSLayoutConstraint!
    @IBOutlet weak var moneyTFHeightCT: NSLayoutConstraint!
    @IBOutlet weak var moneyTFViewTopCT: NSLayoutConstraint!
    
    var currentResiver = PersonModel(name: nil, number: nil)
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resiverView.isHidden = true
        resiverNumberTextField.delegate = self
        moneyTextField.delegate = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "MenuIcon")
        
        self.profileImageView.layer.borderWidth = 1
        self.profileImageView.layer.borderColor = UIColor.clear.cgColor
        self.profileImageView.layer.masksToBounds = false
        self.profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2
        self.profileImageView.clipsToBounds = true
        
        profileImageView.image = UIImage(data: (userDefaults.data(forKey: "PhotoData") ?? UIImage(named: "Icon")?.pngData())!)
    }
    // ContactsButton
    @IBAction func contactsButtonPressed(_ sender: UIButton) {
        let vc = CNContactPickerViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    // Transfer Confirmation Button with error handler
    @IBAction func transferConfirmationButton(_ sender: UIButton) {
        let money = Int(moneyTextField.text!)!
        if money > 100 && currentResiver.name != nil{
            moneyErrorDealer(false)
            phoneErrorDealer(false)
            performSegue(withIdentifier: "goToConfirmation", sender: self)
        }else{
            if money == 0{
                moneyErrorLabel.text = "Вы не указали сумму перевода"
                moneyErrorDealer(true)
            }else if money < 100{
                moneyErrorLabel.text = "Минимальная сумма перевода 100,00 ₸"
                moneyErrorDealer(true)
            }
            if currentResiver.name == nil{
                if let text = resiverNumberTextField.text, text.isEmpty{
                    phoneErrorLabel.text = "Вы не указали номер телефона"
                    phoneErrorDealer(true)
                }else{
                    phoneErrorLabel.text = "Проверьте правильность ввода данных"
                    phoneErrorDealer(true)
                }
            }
        }
    }
    func saveTransaction(){
    }
    
    //Error handler
    func moneyErrorDealer(_ isError: Bool){
        if isError{
            moneyTextFieldsView.layer.borderColor = UIColor.red.cgColor
            moneyTextFieldsView.layer.borderWidth = 0.5
            messageViewHeight.constant = 142
            profilePhotoTopCT.constant = 64
            messageTopCT.constant = 32
            moneyErrorLabel.isHidden = false
        }else{
            moneyTextFieldsView.layer.borderWidth = 0
            messageViewHeight.constant = 126
            profilePhotoTopCT.constant = 48
            messageTopCT.constant = 16
            moneyErrorLabel.isHidden = true
        }
    }
    func phoneErrorDealer(_ isError: Bool){
        if isError{
            phoneView.layer.borderColor = UIColor.red.cgColor
            phoneView.layer.borderWidth = 0.5
            moneyTFHeightCT.constant = 108
            moneyTFViewTopCT.constant = 40
            phoneErrorLabel.isHidden = false
        }else{
            phoneView.layer.borderWidth = 0
            moneyTFHeightCT.constant = 92
            moneyTFViewTopCT.constant = 24
            phoneErrorLabel.isHidden = true
        }
    }
    
    // Message Buttons "Рахмет!" etc
    @IBAction func messageButtonPressed(_ sender: UIButton) {
        messageTextField.text = sender.currentTitle!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToConfirmation"{
            let vc = segue.destination as! ConfirmationController
            vc.name = currentResiver.name!
            vc.money = moneyTextField.text! + " ₸"
            let message = messageTextField.text ?? ""
            if message.isEmpty{
                vc.message = nil
            }else{
                vc.message = message
            }
        }
    }
}

extension TransferViewControler: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == moneyTextField{
            moneyErrorDealer(false)
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            let textToSet: String
            if newText.isEmpty {
                textToSet = "0"
                self.confirmationButton.setTitle("Перевести 0 ₸", for: .normal)
            } else if currentText == "0" && !string.isEmpty && string != "0" {
                textToSet = string
                self.confirmationButton.setTitle("Перевести \(string) ₸", for: .normal)
            } else {
                textToSet = newText
                self.confirmationButton.setTitle("Перевести \(newText) ₸", for: .normal)
            }
            
            // Set the text field's text
            textField.text = textToSet
            return false
            
        }
        if textField == resiverNumberTextField{
            phoneErrorDealer(false)
        }
        return true
    }
    
}

extension TransferViewControler: CNContactPickerDelegate{
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let name = contact.givenName + " " + String(contact.familyName.first!) + "."
        let number = contact.phoneNumbers.map{ $0.value.stringValue }
        currentResiver = PersonModel(name: name, number: number[0])
        moneyTopCT.constant = 64
        resiverView.isHidden = false
        resiverNumberTextField.text = currentResiver.number
        resiverNameLabel.text = currentResiver.name
        phoneErrorDealer(false)
    }
}


