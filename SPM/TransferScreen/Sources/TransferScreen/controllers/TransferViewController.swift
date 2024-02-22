import UIKit
import Contacts
import ContactsUI

class TransferViewController: UIViewController {
    
    private var transferPageView: TransferPageView!
    private var currentResiver = PersonModel(name: nil, number: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Переводы"
        navigationItem.style = .editor
        navigationItem.backButtonTitle = ""
        
        transferPageView = TransferPageView()
        transferPageView.setNumberTextFieldDelegate(self)
        transferPageView.setMoneyTextFieldDelegate(self)
        transferPageView.setupUI(self.view)
        transferPageView.setupContactButton(in: #selector(contactsButtonPressed))
        transferPageView.setupThanksButton(in: #selector(thanksMessageButtonPressed))
        transferPageView.setupForLunchButton(in: #selector(forLunchMessageButtonPressed))
        transferPageView.setupReturningButton(in: #selector(returningMessageButtonPressed))
        transferPageView.setupConfirmationButton(in: #selector(transferConfirmationButton))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        transferPageView.roundProfileImage()
    }
    
    @objc private func contactsButtonPressed() {
        let viewC = CNContactPickerViewController()
        viewC.delegate = self
        present(viewC, animated: true)
    }
    
    @objc private func transferConfirmationButton() {
        let money = Int(transferPageView.getMoneyTextFieldText()!)!
        if money > 100 && currentResiver.name != nil {
            transferPageView.moneyErrorDealer(false)
            transferPageView.phoneErrorDealer(false)
            let viewC = ConfirmationViewController()
            viewC.name = currentResiver.name ?? "Имя Ф."
            viewC.money = (transferPageView.getMoneyTextFieldText() ?? "0") + " ₸"
            let message = transferPageView.getMessageTextFieldText() ?? ""
            if message.isEmpty {
                viewC.message = nil
            } else {
                viewC.message = message
            }
            navigationController?.pushViewController(viewC, animated: true)
        } else {
            if money == 0 {
                transferPageView.setMoneyErrorLabel("Вы не указали сумму перевода")
                transferPageView.moneyErrorDealer(true)
            } else if money < 100 {
                transferPageView.setMoneyErrorLabel("Минимальная сумма перевода 100,00 ₸")
                transferPageView.moneyErrorDealer(true)
            }
            if currentResiver.name == nil {
                if let text = transferPageView.getResiverNumberTextFieldText(), text.isEmpty {
                    transferPageView.setPhoneErrorLabel("Вы не указали номер телефона")
                    transferPageView.phoneErrorDealer(true)
                } else {
                    transferPageView.setPhoneErrorLabel("Проверьте правильность ввода данных")
                    transferPageView.phoneErrorDealer(true)
                }
            }
        }
    }
    @objc private func thanksMessageButtonPressed(sender: UIButton) {
        transferPageView.setMessageTextField("Рахмет!")
    }
    @objc private func forLunchMessageButtonPressed(sender: UIButton) {
        transferPageView.setMessageTextField("За обед")
    }
    @objc private func returningMessageButtonPressed(sender: UIButton) {
        transferPageView.setMessageTextField("Возвращаю :)")
    }
}

extension TransferViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, 
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == transferPageView.getMoneyTextField() {
            transferPageView.moneyErrorDealer(false)
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            let textToSet: String
            if newText.isEmpty {
                textToSet = "0"
                transferPageView.setConfirmationButtonTitle("Перевести 0 ₸")
            } else if currentText == "0" && !string.isEmpty && string != "0" {
                textToSet = string
                transferPageView.setConfirmationButtonTitle("Перевести \(string) ₸")
            } else {
                textToSet = newText
                transferPageView.setConfirmationButtonTitle("Перевести \(newText) ₸")
            }
            textField.text = textToSet
            return false
        }
        if textField == transferPageView.getResiverNumberTextField() {
            transferPageView.phoneErrorDealer(false)
        }
        return true
    }
    
}

extension TransferViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        if let contacyName = contact.familyName.first {
            let name = contact.givenName + " " + String(contacyName) + "."
            let number = contact.phoneNumbers.map { $0.value.stringValue }
            currentResiver = PersonModel(name: name, number: number[0])
            transferPageView.resiverViewPopUp(currentResiver.number ?? "", currentResiver.name ?? "")
            transferPageView.phoneErrorDealer(false)
        } else {
            print("error with contact")
        }
        
    }
}
