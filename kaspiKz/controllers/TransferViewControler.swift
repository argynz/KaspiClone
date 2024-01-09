import UIKit
import Contacts
import ContactsUI

class TransferViewControler: UIViewController{
    
    private var transferViewContent: TransferViewContent!
    private var currentResiver = PersonModel(name: nil, number: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transferViewContent = TransferViewContent()
        transferViewContent.setNumberTextFieldDelegate(self)
        transferViewContent.setMoneyTextFieldDelegate(self)
        transferViewContent.setupUI(self.view)
        transferViewContent.setupContactButton(in: #selector(contactsButtonPressed))
        transferViewContent.setupThanksButton(in: #selector(thanksMessageButtonPressed))
        transferViewContent.setupForLunchButton(in: #selector(forLunchMessageButtonPressed))
        transferViewContent.setupReturningButton(in: #selector(returningMessageButtonPressed))
        transferViewContent.setupConfirmationButton(in: #selector(transferConfirmationButton))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        transferViewContent.roundProfileImage()
    }
    
    @objc private func contactsButtonPressed() {
        let vc = CNContactPickerViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc private func transferConfirmationButton() {
        let money = Int(transferViewContent.getMoneyTextFieldText()!)!
        if money > 100 && currentResiver.name != nil{
            transferViewContent.moneyErrorDealer(false)
            transferViewContent.phoneErrorDealer(false)
            performSegue(withIdentifier: "goToConfirmation", sender: self)
        }else{
            if money == 0{
                transferViewContent.setMoneyErrorLabel("Вы не указали сумму перевода")
                transferViewContent.moneyErrorDealer(true)
            }else if money < 100{
                transferViewContent.setMoneyErrorLabel("Минимальная сумма перевода 100,00 ₸")
                transferViewContent.moneyErrorDealer(true)
            }
            if currentResiver.name == nil{
                if let text = transferViewContent.getResiverNumberTextFieldText(), text.isEmpty{
                    transferViewContent.setPhoneErrorLabel("Вы не указали номер телефона")
                    transferViewContent.phoneErrorDealer(true)
                }else{
                    transferViewContent.setPhoneErrorLabel("Проверьте правильность ввода данных")
                    transferViewContent.phoneErrorDealer(true)
                }
            }
        }
    }
    @objc private func thanksMessageButtonPressed(sender: UIButton) {
        transferViewContent.setMessageTextField("Рахмет!")
    }
    @objc private func forLunchMessageButtonPressed(sender: UIButton) {
        transferViewContent.setMessageTextField("За обед")
    }
    @objc private func returningMessageButtonPressed(sender: UIButton) {
        transferViewContent.setMessageTextField("Возвращаю :)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToConfirmation"{
            let vc = segue.destination as! ConfirmationController
            vc.name = currentResiver.name!
            vc.money = transferViewContent.getMoneyTextFieldText()! + " ₸"
            let message = transferViewContent.getMessageTextFieldText() ?? ""
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
        if textField == transferViewContent.getMoneyTextField(){
            transferViewContent.moneyErrorDealer(false)
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            let textToSet: String
            if newText.isEmpty {
                textToSet = "0"
                transferViewContent.setConfirmationButtonTitle("Перевести 0 ₸")
            } else if currentText == "0" && !string.isEmpty && string != "0" {
                textToSet = string
                transferViewContent.setConfirmationButtonTitle("Перевести \(string) ₸")
            } else {
                textToSet = newText
                transferViewContent.setConfirmationButtonTitle("Перевести \(newText) ₸")
            }
            
            textField.text = textToSet
            return false
            
        }
        if textField == transferViewContent.getResiverNumberTextField(){
            transferViewContent.phoneErrorDealer(false)
        }
        return true
    }
    
}

extension TransferViewControler: CNContactPickerDelegate{
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let name = contact.givenName + " " + String(contact.familyName.first!) + "."
        let number = contact.phoneNumbers.map{ $0.value.stringValue }
        currentResiver = PersonModel(name: name, number: number[0])
        transferViewContent.resiverViewPopUp(currentResiver.number ?? "", currentResiver.name ?? "")
        transferViewContent.phoneErrorDealer(false)
    }
}


