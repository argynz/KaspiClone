import UIKit

class TransferViewContent {
    
    private let userDefaults = UserDefaults.standard
    
    private var moneyTextViewTopConstraint: NSLayoutConstraint?
    private var messageViewHeightConstraint: NSLayoutConstraint?
    private var profilePhotoTopConstraint: NSLayoutConstraint?
    private var messageTopConstraint: NSLayoutConstraint?
    private var moneyTextFieldHeightConstraint: NSLayoutConstraint?
    private var moneyTextFieldViewTopConstraint: NSLayoutConstraint?
    
    lazy private var contactButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "person.circle"), for: .normal)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy private var confirmationButton : UIButton = {
        let confirmationButton = UIButton()
        confirmationButton.setTitle("Перевести 0 ₸", for: .normal)
        confirmationButton.setTitleColor(.white, for: .normal)
        confirmationButton.backgroundColor = UIColor(red: 0/255.0, green: 137/255.0, blue: 209/255.0, alpha: 1)
        confirmationButton.layer.cornerRadius = 6
        confirmationButton.clipsToBounds = true
        confirmationButton.translatesAutoresizingMaskIntoConstraints = false
        return confirmationButton
    }()
    lazy private var thanksButton: UIButton = {
        let button = UIButton()
        button.setTitle("Рахмет!", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = UIColor(red: 224/255.0, green: 224/255.0, blue: 224/255.0, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor(red: 144.0/255.0, green: 144.0/255.0, blue: 144.0/255.0, alpha: 1).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy private var forLunchButton: UIButton = {
        let button = UIButton()
        button.setTitle("За обед", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = UIColor(red: 224/255.0, green: 224/255.0, blue: 224/255.0, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor(red: 144.0/255.0, green: 144.0/255.0, blue: 144.0/255.0, alpha: 1).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy private var returningButton: UIButton = {
        let button = UIButton()
        button.setTitle("Возвращаю :)", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = UIColor(red: 224/255.0, green: 224/255.0, blue: 224/255.0, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor(red: 144.0/255.0, green: 144.0/255.0, blue: 144.0/255.0, alpha: 1).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy private var profileImageView : UIImageView = {
        var profileImageView = UIImageView()
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.clear.cgColor
        profileImageView.clipsToBounds = true
        profileImageView.image = UIImage(data: (userDefaults.data(forKey: "PhotoData") ?? UIImage(named: "Icon")?.pngData())!)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        return profileImageView
    }()
    
    private let bottomView : UIView
    private let commissionLabel : UILabel
    private let messageView : UIView
    private let messageTFView : UIView
    private let messageTextField : UITextField
    private let moneyErrorLabel: UILabel
    private let moneyTextView : UIView
    private let moneyTFView : UIView
    private let moneyTextField : UITextField
    private let phoneErrorLabel: UILabel
    private let resiverView : UIView
    private let resiverNameLabel: UILabel
    private let resiverDescriptionLabel: UILabel
    private let phoneTextFieldView : UIView
    private let resiverNumberTextField : UITextField
    private let cardImage: UIImageView
    private let kaspiLabel: UILabel
    private let balanceLabel: UILabel
    private let arrowImage: UIImageView
    private let segmentController: UISegmentedControl
    private let mainView: UIView
    private let stackView: UIStackView
    private let topView: UIView
    private let cardView: UIView
    
    init() {
        balanceLabel = UILabel()
        balanceLabel.text = "123 456,78 ₸"
        
        kaspiLabel = UILabel()
        kaspiLabel.text = "Kaspi Gold"
        
        resiverDescriptionLabel = UILabel()
        resiverDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 12)
        resiverDescriptionLabel.textColor = .white
        resiverDescriptionLabel.text = "Деньги поступят на карту Kaspi Gold"
        
        resiverNameLabel = UILabel()
        resiverNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        resiverNameLabel.textColor = .white
        resiverNameLabel.text = "Имя Ф."
        
        phoneErrorLabel = UILabel()
        phoneErrorLabel.font = UIFont.systemFont(ofSize: 12)
        phoneErrorLabel.textColor = .red
        phoneErrorLabel.text = "Вы не указали номер телефона"
        
        moneyErrorLabel = UILabel()
        moneyErrorLabel.font = UIFont.systemFont(ofSize: 12)
        moneyErrorLabel.textColor = .red
        moneyErrorLabel.text = "Вы не указали сумму перевода"
        
        commissionLabel = UILabel()
        commissionLabel.text = "Комиссия 0 ₸"
        commissionLabel.font = UIFont.systemFont(ofSize: 14)
        commissionLabel.textColor = UIColor(red: 144.0/255.0, green: 144.0/255.0, blue: 144.0/255.0, alpha: 1)
        
        arrowImage = UIImageView()
        arrowImage.image = UIImage(named: "DownArrow")
        
        cardImage = UIImageView()
        cardImage.image = UIImage(named: "CardIcon")
        
        resiverNumberTextField = UITextField()
        let resiverNumberTextFieldplaceholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 144.0/255.0, green: 144.0/255.0, blue: 144.0/255.0, alpha: 1),
            .font: UIFont.systemFont(ofSize: 16)
        ]
        resiverNumberTextField.attributedPlaceholder = NSAttributedString(string: "Телефон получателя", attributes: resiverNumberTextFieldplaceholderAttributes)
        resiverNumberTextField.textColor = UIColor.black
        
        moneyTextField = UITextField()
        moneyTextField.textColor = .black
        moneyTextField.font = UIFont.systemFont(ofSize: 32)
        moneyTextField.text = "0"
        moneyTextField.textAlignment = .center
        
        messageTextField = UITextField()
        let messageTextFieldplaceholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 144.0/255.0, green: 144.0/255.0, blue: 144.0/255.0, alpha: 1),
            .font: UIFont.systemFont(ofSize: 16)
        ]
        messageTextField.attributedPlaceholder = NSAttributedString(string: "Сообщение получателю", attributes: messageTextFieldplaceholderAttributes)
        messageTextField.textColor = UIColor.black
        
        segmentController = UISegmentedControl(items: ["Телефон", "Карта", "Каспи QR"])
        segmentController.selectedSegmentTintColor = UIColor.red
        segmentController.backgroundColor = .white
        segmentController.selectedSegmentIndex = 0
        segmentController.layer.borderWidth = 1
        segmentController.layer.borderColor = UIColor.red.cgColor
        segmentController.layer.cornerRadius = 5
        segmentController.clipsToBounds = true
        let normalFontAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.red,
            .font: UIFont.systemFont(ofSize: 12)
        ]
        let selectedFontAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 12)
        ]
        segmentController.setTitleTextAttributes(normalFontAttributes, for: .normal)
        segmentController.setTitleTextAttributes(selectedFontAttributes, for: .selected)
        
        resiverView = UIView()
        resiverView.backgroundColor = UIColor(red: 213/255.0, green: 174/255.0, blue: 108/255.0, alpha: 1)
        
        mainView = UIView()
        mainView.backgroundColor = UIColor(red: 224/255.0, green: 224/255.0, blue: 224/255.0, alpha: 1)
        
        phoneTextFieldView = UIView()
        phoneTextFieldView.backgroundColor = .white
        
        topView = UIView()
        
        cardView = UIView()
        cardView.backgroundColor = .white
        
        moneyTFView = UIView()
        moneyTFView.backgroundColor = .white
        
        moneyTextView = UIView()
        
        messageTFView = UIView()
        messageTFView.backgroundColor = .white
        
        messageView = UIView()
        
        bottomView = UIView()
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        
        [balanceLabel, arrowImage, segmentController, mainView, stackView, topView, cardView, kaspiLabel, phoneTextFieldView, resiverNumberTextField, resiverView, resiverNameLabel, resiverDescriptionLabel, moneyTextView, phoneErrorLabel, moneyTFView, moneyTextField, messageView, moneyErrorLabel, messageTFView, messageTextField, profileImageView, bottomView, commissionLabel, cardImage].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        resiverView.isHidden = true
        phoneErrorLabel.isHidden = true
        moneyErrorLabel.isHidden = true
    }
    
    private func setupSubviews(_ containerView: UIView){
        containerView.addSubview(mainView)
        mainView.addSubview(stackView)
        stackView.addSubview(topView)
        topView.addSubview(cardView)
        cardView.addSubview(cardImage)
        cardView.addSubview(kaspiLabel)
        cardView.addSubview(balanceLabel)
        cardView.addSubview(arrowImage)
        topView.addSubview(segmentController)
        stackView.addSubview(phoneTextFieldView)
        phoneTextFieldView.addSubview(resiverNumberTextField)
        stackView.addSubview(resiverView)
        resiverView.addSubview(resiverNameLabel)
        stackView.addSubview(moneyTextView)
        resiverView.addSubview(resiverDescriptionLabel)
        moneyTextView.addSubview(phoneErrorLabel)
        moneyTextView.addSubview(moneyTFView)
        moneyTFView.addSubview(moneyTextField)
        stackView.addSubview(messageView)
        messageView.addSubview(moneyErrorLabel)
        messageView.addSubview(messageTFView)
        messageTFView.addSubview(messageTextField)
        messageView.addSubview(profileImageView)
        stackView.addSubview(bottomView)
        bottomView.addSubview(commissionLabel)
    }
    
    private func setupConstraints(_ containerView: UIView){
        moneyTextViewTopConstraint = moneyTextView.topAnchor.constraint(equalTo: phoneTextFieldView.bottomAnchor)
        moneyTextFieldHeightConstraint = moneyTextView.heightAnchor.constraint(equalToConstant: 92)
        moneyTextFieldViewTopConstraint = moneyTFView.topAnchor.constraint(equalTo: moneyTextView.topAnchor, constant: 24)
        messageViewHeightConstraint = messageView.heightAnchor.constraint(equalToConstant: 126)
        messageTopConstraint = messageTFView.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 16)
        profilePhotoTopConstraint = profileImageView.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 48)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: mainView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            
            topView.topAnchor.constraint(equalTo: stackView.topAnchor),
            topView.heightAnchor.constraint(equalToConstant: 165),
            topView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            cardView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 12),
            cardView.heightAnchor.constraint(equalToConstant: 76),
            cardView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            cardImage.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            cardImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            cardImage.heightAnchor.constraint(equalToConstant: 52),
            cardImage.widthAnchor.constraint(equalToConstant: 52),
            
            kaspiLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            kaspiLabel.leadingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: 12),
            
            balanceLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            balanceLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            
            arrowImage.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            arrowImage.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 62),
            arrowImage.heightAnchor.constraint(equalToConstant: 24),
            arrowImage.widthAnchor.constraint(equalToConstant: 24),
            
            segmentController.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            segmentController.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -20),
            segmentController.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 9),
            
            phoneTextFieldView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            phoneTextFieldView.heightAnchor.constraint(equalToConstant: 64),
            phoneTextFieldView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            phoneTextFieldView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            resiverNumberTextField.centerYAnchor.constraint(equalTo: phoneTextFieldView.centerYAnchor),
            resiverNumberTextField.leadingAnchor.constraint(equalTo: phoneTextFieldView.leadingAnchor, constant: 16),
            
            resiverView.topAnchor.constraint(equalTo: phoneTextFieldView.bottomAnchor),
            resiverView.heightAnchor.constraint(equalToConstant: 64),
            resiverView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            resiverView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            resiverNameLabel.topAnchor.constraint(equalTo: resiverView.topAnchor, constant: 16),
            resiverNameLabel.leadingAnchor.constraint(equalTo: resiverView.leadingAnchor, constant: 16),
            
            resiverDescriptionLabel.bottomAnchor.constraint(equalTo: resiverView.bottomAnchor, constant: -10),
            resiverDescriptionLabel.leadingAnchor.constraint(equalTo: resiverView.leadingAnchor, constant: 16),
            
            moneyTextViewTopConstraint,
            moneyTextFieldHeightConstraint,
            moneyTextView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            moneyTextView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            phoneErrorLabel.topAnchor.constraint(equalTo: moneyTextView.topAnchor, constant: 8),
            phoneErrorLabel.leadingAnchor.constraint(equalTo: moneyTextView.leadingAnchor, constant: 16),
            
            moneyTextFieldViewTopConstraint,
            moneyTFView.bottomAnchor.constraint(equalTo: moneyTextView.bottomAnchor),
            moneyTFView.leadingAnchor.constraint(equalTo: moneyTextView.leadingAnchor),
            moneyTFView.trailingAnchor.constraint(equalTo: moneyTextView.trailingAnchor),
            
            moneyTextField.topAnchor.constraint(equalTo: moneyTFView.topAnchor, constant: 10),
            moneyTextField.bottomAnchor.constraint(equalTo: moneyTFView.bottomAnchor, constant: -10),
            moneyTextField.leadingAnchor.constraint(equalTo: moneyTFView.leadingAnchor, constant: 8),
            moneyTextField.trailingAnchor.constraint(equalTo: moneyTFView.trailingAnchor, constant: -8),
            
            messageView.topAnchor.constraint(equalTo: moneyTextView.bottomAnchor),
            messageViewHeightConstraint,
            messageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            messageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            moneyErrorLabel.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 8),
            moneyErrorLabel.centerXAnchor.constraint(equalTo: messageView.centerXAnchor),
            
            messageTopConstraint,
            messageTFView.heightAnchor.constraint(equalToConstant: 72),
            messageTFView.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: 16),
            messageTFView.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: -73),
            
            messageTextField.leadingAnchor.constraint(equalTo: messageTFView.leadingAnchor, constant: 16),
            messageTextField.centerYAnchor.constraint(equalTo: messageTFView.centerYAnchor, constant: 0),
            
            profilePhotoTopConstraint,
            profileImageView.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: -16),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            
            
            bottomView.topAnchor.constraint(equalTo: messageView.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 118),
            bottomView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            commissionLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            commissionLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20)
        ].compactMap { $0 })
    }
    
    func setupUI(_ containerView: UIView) {
        setupSubviews(containerView)
        setupConstraints(containerView)
    }
    
    func setupContactButton(in action: Selector) {
        phoneTextFieldView.addSubview(contactButton)
        
        NSLayoutConstraint.activate([
            contactButton.topAnchor.constraint(equalTo: phoneTextFieldView.topAnchor, constant: 16),
            contactButton.trailingAnchor.constraint(equalTo: phoneTextFieldView.trailingAnchor, constant: -16),
            contactButton.heightAnchor.constraint(equalToConstant: 35),
            contactButton.widthAnchor.constraint(equalToConstant: 50),
        ])
        
        contactButton.addTarget(nil, action: action, for: .touchUpInside)
    }
    
    func setupConfirmationButton(in action: Selector) {
        bottomView.addSubview(confirmationButton)
        
        NSLayoutConstraint.activate([
            confirmationButton.topAnchor.constraint(equalTo: commissionLabel.bottomAnchor, constant: 21),
            confirmationButton.heightAnchor.constraint(equalToConstant: 60),
            confirmationButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            confirmationButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            confirmationButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
        ])
        
        confirmationButton.addTarget(nil, action: action, for: .touchUpInside)
    }
    
    func setupThanksButton(in action: Selector) {
        messageView.addSubview(thanksButton)
        
        NSLayoutConstraint.activate([
            thanksButton.topAnchor.constraint(equalTo: messageTFView.bottomAnchor, constant: 16),
            thanksButton.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: 16),
            thanksButton.heightAnchor.constraint(equalToConstant: 26),
        ])
        
        thanksButton.addTarget(nil, action: action, for: .touchUpInside)
    }
    
    func setupForLunchButton(in action: Selector) {
        messageView.addSubview(forLunchButton)
        
        NSLayoutConstraint.activate([
            forLunchButton.topAnchor.constraint(equalTo: messageTFView.bottomAnchor, constant: 16),
            forLunchButton.leadingAnchor.constraint(equalTo: thanksButton.trailingAnchor, constant: 8),
            forLunchButton.heightAnchor.constraint(equalToConstant: 26),
        ])
        
        forLunchButton.addTarget(nil, action: action, for: .touchUpInside)
    }
    
    func setupReturningButton(in action: Selector) {
        messageView.addSubview(returningButton)
        
        NSLayoutConstraint.activate([
            returningButton.topAnchor.constraint(equalTo: messageTFView.bottomAnchor, constant: 16),
            returningButton.leadingAnchor.constraint(equalTo: forLunchButton.trailingAnchor, constant: 8),
            returningButton.heightAnchor.constraint(equalToConstant: 26),
        ])
        
        returningButton.addTarget(nil, action: action, for: .touchUpInside)
    }
    
    func moneyErrorDealer(_ isError: Bool){
        if isError{
            moneyTFView.layer.borderColor = UIColor.red.cgColor
            moneyTFView.layer.borderWidth = 0.5
            messageViewHeightConstraint?.constant = 142
            profilePhotoTopConstraint?.constant = 64
            messageTopConstraint?.constant = 32
            moneyErrorLabel.isHidden = false
        }else{
            moneyTFView.layer.borderWidth = 0
            messageViewHeightConstraint?.constant = 126
            profilePhotoTopConstraint?.constant = 48
            messageTopConstraint?.constant = 16
            moneyErrorLabel.isHidden = true
        }
    }
    func phoneErrorDealer(_ isError: Bool){
        if isError{
            phoneTextFieldView.layer.borderColor = UIColor.red.cgColor
            phoneTextFieldView.layer.borderWidth = 0.5
            moneyTextFieldHeightConstraint?.constant = 108
            moneyTextFieldViewTopConstraint?.constant = 40
            phoneErrorLabel.isHidden = false
        }else{
            phoneTextFieldView.layer.borderWidth = 0
            moneyTextFieldHeightConstraint?.constant = 92
            moneyTextFieldViewTopConstraint?.constant = 24
            phoneErrorLabel.isHidden = true
        }
    }
    func roundProfileImage(){
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
    }
    func resiverViewPopUp(_ number: String, _ name: String){
        moneyTextViewTopConstraint?.constant = 64
        resiverView.isHidden = false
        resiverNumberTextField.text = number
        resiverNameLabel.text = name
    }
    
    func getResiverNumberTextField() -> UITextField{
        return resiverNumberTextField
    }
    func getMoneyTextField() -> UITextField{
        return moneyTextField
    }
    func getMoneyTextFieldText() -> String? {
            return moneyTextField.text
        }
    func getResiverNumberTextFieldText() -> String? {
            return resiverNumberTextField.text
        }
    func getMessageTextFieldText() -> String? {
            return messageTextField.text
        }
    func setNumberTextFieldDelegate(_ delegate: UITextFieldDelegate) {
            resiverNumberTextField.delegate = delegate
        }
    func setMoneyTextFieldDelegate(_ delegate: UITextFieldDelegate) {
            moneyTextField.delegate = delegate
        }
    func setConfirmationButtonTitle(_ title: String){
        confirmationButton.setTitle(title, for: .normal)
    }
    func setMessageTextField(_ text:String){
            messageTextField.text = text
        }
    func setMoneyErrorLabel(_ text:String) {
        moneyErrorLabel.text = text
    }
    func setPhoneErrorLabel(_ text:String) {
        phoneErrorLabel.text = text
    }
    func updateMoneyTextViewTopConstraint(to constant: CGFloat) {
        moneyTextViewTopConstraint?.constant = constant
    }
    func updateMessageViewHeightConstraint(to constant: CGFloat) {
        messageViewHeightConstraint?.constant = constant
    }
    func updateProfilePhotoTopConstraint(to constant: CGFloat) {
        profilePhotoTopConstraint?.constant = constant
    }
    func updateMessageTopConstraint(to constant: CGFloat) {
        messageTopConstraint?.constant = constant
    }
    func updateMoneyTextFieldHeightConstraint(to constant: CGFloat) {
        moneyTextFieldHeightConstraint?.constant = constant
    }
    func updateMoneyTextFieldTopConstraint(to constant: CGFloat) {
        moneyTextFieldViewTopConstraint?.constant = constant
    }
    
}
