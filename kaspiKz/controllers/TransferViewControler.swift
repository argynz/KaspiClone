import UIKit
import Contacts
import ContactsUI

class TransferViewControler: UIViewController{
    
    let userDefaults = UserDefaults.standard
    
    var moneyTextViewTopCT: NSLayoutConstraint!
    var messageViewHeight: NSLayoutConstraint!
    var profilePhotoTopCT: NSLayoutConstraint!
    var messageTopCT: NSLayoutConstraint!
    var moneyTFHeightCT: NSLayoutConstraint!
    var moneyTFViewTopCT: NSLayoutConstraint!
    
    let bottomView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var confirmationButton : UIButton = {
        let confirmationButton = UIButton()
        confirmationButton.translatesAutoresizingMaskIntoConstraints = false
        confirmationButton.setTitle("Перевести 0 ₸", for: .normal)
        confirmationButton.setTitleColor(.white, for: .normal)
        confirmationButton.backgroundColor = UIColor(red: 0/255.0, green: 137/255.0, blue: 209/255.0, alpha: 1)
        confirmationButton.layer.cornerRadius = 6
        confirmationButton.clipsToBounds = true
        confirmationButton.addTarget(self, action: #selector(transferConfirmationButton), for: .touchUpInside)
        return confirmationButton
    }()
    lazy var commissionLabel : UILabel = {
        let commissionLabel = UILabel()
        commissionLabel.translatesAutoresizingMaskIntoConstraints = false
        commissionLabel.text = "Комиссия 0 ₸"
        commissionLabel.font = UIFont.systemFont(ofSize: 14)
        commissionLabel.textColor = UIColor(red: 144.0/255.0, green: 144.0/255.0, blue: 144.0/255.0, alpha: 1)
        return commissionLabel
    }()
    
    var messageView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var messageTFView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var messageTextField : UITextField = {
        let textField = UITextField()
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 144.0/255.0, green: 144.0/255.0, blue: 144.0/255.0, alpha: 1),
            .font: UIFont.systemFont(ofSize: 16)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Сообщение получателю", attributes: placeholderAttributes)
        
        // Set the text color to black
        textField.textColor = UIColor.black
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    lazy var profileImageView : UIImageView = {
        var profileImageView = UIImageView()
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.clear.cgColor
        profileImageView.clipsToBounds = true
        profileImageView.image = UIImage(data: (userDefaults.data(forKey: "PhotoData") ?? UIImage(named: "Icon")?.pngData())!)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        return profileImageView
    }()
    lazy var thanksButton: UIButton = {
        let button = UIButton()
        button.setTitle("Рахмет!", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = UIColor(red: 224/255.0, green: 224/255.0, blue: 224/255.0, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor(red: 144.0/255.0, green: 144.0/255.0, blue: 144.0/255.0, alpha: 1).cgColor
        button.addTarget(self, action: #selector(messageButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var forLunchButton: UIButton = {
        let button = UIButton()
        button.setTitle("За обед", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = UIColor(red: 224/255.0, green: 224/255.0, blue: 224/255.0, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor(red: 144.0/255.0, green: 144.0/255.0, blue: 144.0/255.0, alpha: 1).cgColor
        button.addTarget(self, action: #selector(messageButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var returningButton: UIButton = {
        let button = UIButton()
        button.setTitle("Возвращаю :)", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = UIColor(red: 224/255.0, green: 224/255.0, blue: 224/255.0, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor(red: 144.0/255.0, green: 144.0/255.0, blue: 144.0/255.0, alpha: 1).cgColor
        button.addTarget(self, action: #selector(messageButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var moneyErrorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .red
        label.text = "Вы не указали сумму перевода"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var moneyTextView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var moneyTFView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var moneyTextField : UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 32)
        textField.text = "0"
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    var phoneErrorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .red
        label.text = "Вы не указали номер телефона"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var resiverView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 213/255.0, green: 174/255.0, blue: 108/255.0, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var resiverNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.text = "Имя Ф."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var resiverDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.text = "Деньги поступят на карту Kaspi Gold"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var phoneTextFieldView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var resiverNumberTextField : UITextField = {
        let textField = UITextField()
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 144.0/255.0, green: 144.0/255.0, blue: 144.0/255.0, alpha: 1),
            .font: UIFont.systemFont(ofSize: 16)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Телефон получателя", attributes: placeholderAttributes)
        
        // Set the text color to black
        textField.textColor = UIColor.black
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    lazy var contactButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "person.circle"), for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(contactsButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var topView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var cardView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var cardImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "CardIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    var kaspiLabel: UILabel = {
        let label = UILabel()
        label.text = "Kaspi Gold"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "123 456,78 ₸"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var arrowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "DownArrow")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    var segmentController: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Телефон", "Карта", "Каспи QR"])
        segmentedControl.selectedSegmentTintColor = UIColor.red
        segmentedControl.backgroundColor = .white
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.borderColor = UIColor.red.cgColor
        segmentedControl.layer.cornerRadius = 5
        segmentedControl.clipsToBounds = true
        let normalFontAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.red,
            .font: UIFont.systemFont(ofSize: 12)
        ]
        let selectedFontAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 12)
        ]
        segmentedControl.setTitleTextAttributes(normalFontAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedFontAttributes, for: .selected)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 224/255.0, green: 224/255.0, blue: 224/255.0, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    var currentResiver = PersonModel(name: nil, number: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
    }
    
    func SetupUI(){
        resiverView.isHidden = true
        resiverNumberTextField.delegate = self
        moneyTextField.delegate = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "MenuIcon")
        
        view.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        mainView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: mainView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
        
        stackView.addSubview(topView)
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: stackView.topAnchor),
            topView.heightAnchor.constraint(equalToConstant: 165),
            topView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        topView.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 12),
            cardView.heightAnchor.constraint(equalToConstant: 76),
            cardView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        cardView.addSubview(cardImage)
        NSLayoutConstraint.activate([
            cardImage.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            cardImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            cardImage.heightAnchor.constraint(equalToConstant: 52),
            cardImage.widthAnchor.constraint(equalToConstant: 52)
        ])
        
        cardView.addSubview(kaspiLabel)
        NSLayoutConstraint.activate([
            kaspiLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            kaspiLabel.leadingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: 12)
        ])
        cardView.addSubview(balanceLabel)
        NSLayoutConstraint.activate([
            balanceLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            balanceLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16)
        ])
        cardView.addSubview(arrowImage)
        NSLayoutConstraint.activate([
            arrowImage.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            arrowImage.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 62),
            arrowImage.heightAnchor.constraint(equalToConstant: 24),
            arrowImage.widthAnchor.constraint(equalToConstant: 24)
        ])
        topView.addSubview(segmentController)
        NSLayoutConstraint.activate([
            segmentController.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            segmentController.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -20),
            segmentController.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 9)
        ])
        
        stackView.addSubview(phoneTextFieldView)
        NSLayoutConstraint.activate([
            phoneTextFieldView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            phoneTextFieldView.heightAnchor.constraint(equalToConstant: 64),
            phoneTextFieldView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            phoneTextFieldView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        phoneTextFieldView.addSubview(resiverNumberTextField)
        NSLayoutConstraint.activate([
            resiverNumberTextField.centerYAnchor.constraint(equalTo: phoneTextFieldView.centerYAnchor),
            resiverNumberTextField.leadingAnchor.constraint(equalTo: phoneTextFieldView.leadingAnchor, constant: 16)
        ])
        phoneTextFieldView.addSubview(contactButton)
        NSLayoutConstraint.activate([
            contactButton.topAnchor.constraint(equalTo: phoneTextFieldView.topAnchor, constant: 16),
            contactButton.trailingAnchor.constraint(equalTo: phoneTextFieldView.trailingAnchor, constant: -16),
            contactButton.heightAnchor.constraint(equalToConstant: 35),
            contactButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        stackView.addSubview(resiverView)
        NSLayoutConstraint.activate([
            resiverView.topAnchor.constraint(equalTo: phoneTextFieldView.bottomAnchor),
            resiverView.heightAnchor.constraint(equalToConstant: 64),
            resiverView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            resiverView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        resiverView.addSubview(resiverNameLabel)
        NSLayoutConstraint.activate([
            resiverNameLabel.topAnchor.constraint(equalTo: resiverView.topAnchor, constant: 16),
            resiverNameLabel.leadingAnchor.constraint(equalTo: resiverView.leadingAnchor, constant: 16)
        ])
        resiverView.addSubview(resiverDescriptionLabel)
        NSLayoutConstraint.activate([
            resiverDescriptionLabel.bottomAnchor.constraint(equalTo: resiverView.bottomAnchor, constant: -10),
            resiverDescriptionLabel.leadingAnchor.constraint(equalTo: resiverView.leadingAnchor, constant: 16)
        ])
        resiverView.isHidden = true
        
        stackView.addSubview(moneyTextView)
        moneyTextViewTopCT = moneyTextView.topAnchor.constraint(equalTo: phoneTextFieldView.bottomAnchor)
        moneyTFHeightCT = moneyTextView.heightAnchor.constraint(equalToConstant: 92)
        NSLayoutConstraint.activate([
            moneyTextViewTopCT,
            moneyTFHeightCT,
            moneyTextView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            moneyTextView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        moneyTextView.addSubview(phoneErrorLabel)
        NSLayoutConstraint.activate([
            phoneErrorLabel.topAnchor.constraint(equalTo: moneyTextView.topAnchor, constant: 8),
            phoneErrorLabel.leadingAnchor.constraint(equalTo: moneyTextView.leadingAnchor, constant: 16)
        ])
        phoneErrorLabel.isHidden = true
        moneyTextView.addSubview(moneyTFView)
        moneyTFViewTopCT = moneyTFView.topAnchor.constraint(equalTo: moneyTextView.topAnchor, constant: 24)
        NSLayoutConstraint.activate([
            moneyTFViewTopCT,
            moneyTFView.bottomAnchor.constraint(equalTo: moneyTextView.bottomAnchor),
            moneyTFView.leadingAnchor.constraint(equalTo: moneyTextView.leadingAnchor),
            moneyTFView.trailingAnchor.constraint(equalTo: moneyTextView.trailingAnchor)
        ])
        moneyTFView.addSubview(moneyTextField)
        NSLayoutConstraint.activate([
            moneyTextField.topAnchor.constraint(equalTo: moneyTFView.topAnchor, constant: 10),
            moneyTextField.bottomAnchor.constraint(equalTo: moneyTFView.bottomAnchor, constant: -10),
            moneyTextField.leadingAnchor.constraint(equalTo: moneyTFView.leadingAnchor, constant: 8),
            moneyTextField.trailingAnchor.constraint(equalTo: moneyTFView.trailingAnchor, constant: -8)
        ])
        
        stackView.addSubview(messageView)
        messageViewHeight = messageView.heightAnchor.constraint(equalToConstant: 126)
        NSLayoutConstraint.activate([
            messageView.topAnchor.constraint(equalTo: moneyTextView.bottomAnchor),
            messageViewHeight,
            messageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            messageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        messageView.addSubview(moneyErrorLabel)
        NSLayoutConstraint.activate([
            moneyErrorLabel.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 8),
            moneyErrorLabel.centerXAnchor.constraint(equalTo: messageView.centerXAnchor)
        ])
        moneyErrorLabel.isHidden = true
        messageView.addSubview(messageTFView)
        messageTopCT = messageTFView.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 16)
        NSLayoutConstraint.activate([
            messageTopCT,
            messageTFView.heightAnchor.constraint(equalToConstant: 72),
            messageTFView.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: 16),
            messageTFView.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: -73)
        ])
        
        messageTFView.addSubview(messageTextField)
        NSLayoutConstraint.activate([
            messageTextField.leadingAnchor.constraint(equalTo: messageTFView.leadingAnchor, constant: 16),
            messageTextField.centerYAnchor.constraint(equalTo: messageTFView.centerYAnchor, constant: 0)
        ])
        
        messageView.addSubview(profileImageView)
        profilePhotoTopCT = profileImageView.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 48)
        NSLayoutConstraint.activate([
            profilePhotoTopCT,
            profileImageView.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: -16),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            profileImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        messageView.addSubview(thanksButton)
        NSLayoutConstraint.activate([
            thanksButton.topAnchor.constraint(equalTo: messageTFView.bottomAnchor, constant: 16),
            thanksButton.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: 16),
            thanksButton.heightAnchor.constraint(equalToConstant: 26)
        ])
        messageView.addSubview(forLunchButton)
        NSLayoutConstraint.activate([
            forLunchButton.topAnchor.constraint(equalTo: messageTFView.bottomAnchor, constant: 16),
            forLunchButton.leadingAnchor.constraint(equalTo: thanksButton.trailingAnchor, constant: 8),
            forLunchButton.heightAnchor.constraint(equalToConstant: 26)
        ])
        messageView.addSubview(returningButton)
        NSLayoutConstraint.activate([
            returningButton.topAnchor.constraint(equalTo: messageTFView.bottomAnchor, constant: 16),
            returningButton.leadingAnchor.constraint(equalTo: forLunchButton.trailingAnchor, constant: 8),
            returningButton.heightAnchor.constraint(equalToConstant: 26)
        ])
        
        stackView.addSubview(bottomView)
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: messageView.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 118),
            bottomView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])

        // Create ConfirmationButton
        bottomView.addSubview(confirmationButton)
        NSLayoutConstraint.activate([
            confirmationButton.heightAnchor.constraint(equalToConstant: 60),
            confirmationButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            confirmationButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            confirmationButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
        ])

        // Create Commission Label
        bottomView.addSubview(commissionLabel)
        NSLayoutConstraint.activate([
            commissionLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            commissionLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20),
            confirmationButton.topAnchor.constraint(equalTo: commissionLabel.bottomAnchor, constant: 21)
        ])
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
    }
    
    // ContactsButton
    @objc func contactsButtonPressed() {
        let vc = CNContactPickerViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    // Transfer Confirmation Button with error handler
    @objc func transferConfirmationButton() {
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
    @objc func messageButtonPressed(sender: UIButton) {
        messageTextField.text = sender.currentTitle!
    }
    
    func saveTransaction(){
    }
    
    //Error handler
    func moneyErrorDealer(_ isError: Bool){
        if isError{
            moneyTFView.layer.borderColor = UIColor.red.cgColor
            moneyTFView.layer.borderWidth = 0.5
            messageViewHeight.constant = 142
            profilePhotoTopCT.constant = 64
            messageTopCT.constant = 32
            moneyErrorLabel.isHidden = false
        }else{
            moneyTFView.layer.borderWidth = 0
            messageViewHeight.constant = 126
            profilePhotoTopCT.constant = 48
            messageTopCT.constant = 16
            moneyErrorLabel.isHidden = true
        }
    }
    func phoneErrorDealer(_ isError: Bool){
        if isError{
            phoneTextFieldView.layer.borderColor = UIColor.red.cgColor
            phoneTextFieldView.layer.borderWidth = 0.5
            moneyTFHeightCT.constant = 108
            moneyTFViewTopCT.constant = 40
            phoneErrorLabel.isHidden = false
        }else{
            phoneTextFieldView.layer.borderWidth = 0
            moneyTFHeightCT.constant = 92
            moneyTFViewTopCT.constant = 24
            phoneErrorLabel.isHidden = true
        }
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
        moneyTextViewTopCT.constant = 64
        resiverView.isHidden = false
        resiverNumberTextField.text = currentResiver.number
        resiverNameLabel.text = currentResiver.name
        phoneErrorDealer(false)
    }
}


