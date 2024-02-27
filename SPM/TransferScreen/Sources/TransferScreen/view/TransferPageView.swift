import UIKit
import Const

class TransferPageView {
    private let userDefaults = UserDefaults.standard
    private lazy var contactButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "person.circle"), for: .normal)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var confirmationButton: UIButton = {
        let confirmationButton = UIButton()
        confirmationButton.setTitle("Перевести 0 ₸", for: .normal)
        confirmationButton.setTitleColor(.white, for: .normal)
        confirmationButton.backgroundColor = .customBlueColor
        confirmationButton.layer.cornerRadius = 6
        confirmationButton.clipsToBounds = true
        confirmationButton.translatesAutoresizingMaskIntoConstraints = false
        return confirmationButton
    }()
    private lazy var thanksButton: CustomMessageButton = {
        return CustomMessageButton(title: "Рахмет!")
    }()

    private lazy var forLunchButton: CustomMessageButton = {
        return CustomMessageButton(title: "За обед")
    }()

    private lazy var returningButton: CustomMessageButton = {
        return CustomMessageButton(title: "Возвращаю :)")
    }()
    private lazy var profileImageView: UIImageView = {
        var profileImageView = UIImageView()
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.clear.cgColor
        profileImageView.clipsToBounds = true
        profileImageView.image = UIImage(
            data: (
                userDefaults.data(forKey: "PhotoData") ?? UIImage(named: "Icon")?.pngData())!)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        return profileImageView
    }()
    private let bottomView: UIView
    private let commissionLabel: UILabel
    private let messageView: UIView
    private let messageTFView: UIView
    private let messageTextField: UITextField
    private let moneyErrorView: UIView
    private let moneyErrorLabel: UILabel
    private let moneyTextView: UIView
    private let moneyTFView: UIView
    private let moneyTextField: UITextField
    private let phoneErrorView: UIView
    private let phoneErrorLabel: UILabel
    private let resiverView: UIView
    private let resiverNameLabel: UILabel
    private let resiverDescriptionLabel: UILabel
    private let phoneTextFieldView: UIView
    private let resiverNumberTextField: UITextField
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
        kaspiLabel = UILabel()
        resiverDescriptionLabel = UILabel()
        resiverNameLabel = UILabel()
        moneyErrorView = UIView()
        phoneErrorView = UIView()
        phoneErrorLabel = UILabel()
        moneyErrorLabel = UILabel()
        commissionLabel = UILabel()
        arrowImage = UIImageView()
        cardImage = UIImageView()
        resiverNumberTextField = UITextField()
        moneyTextField = UITextField()
        messageTextField = UITextField()
        segmentController = UISegmentedControl(items: ["Телефон", "Карта", "Каспи QR"])
        resiverView = UIView()
        mainView = UIView()
        phoneTextFieldView = UIView()
        topView = UIView()
        cardView = UIView()
        moneyTFView = UIView()
        moneyTextView = UIView()
        messageTFView = UIView()
        messageView = UIView()
        bottomView = UIView()
        stackView = UIStackView()
        setupUIContent()
        [balanceLabel, arrowImage, segmentController, mainView, stackView, topView, cardView, kaspiLabel,
         phoneTextFieldView, resiverNumberTextField, resiverView, resiverNameLabel, resiverDescriptionLabel,
         moneyTextView, phoneErrorLabel, moneyTFView, moneyTextField, messageView, moneyErrorLabel, messageTFView,
         messageTextField, profileImageView, bottomView, commissionLabel, cardImage, phoneErrorView, moneyErrorView]
            .forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        resiverView.isHidden = true
        phoneErrorView.isHidden = true
        moneyErrorView.isHidden = true
    }
    private func setupUIContent() {
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
        messageTFView.backgroundColor = .white
        moneyTFView.backgroundColor = .white
        cardView.backgroundColor = .white
        phoneTextFieldView.backgroundColor = .white
        mainView.backgroundColor = .lightGrayColor
        resiverView.backgroundColor = .customGoldColor
        moneyErrorView.backgroundColor = .lightGrayColor
        phoneErrorView.backgroundColor = .lightGrayColor
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
        let messageTextFieldplaceholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.mediumGrayColor,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        messageTextField.attributedPlaceholder = NSAttributedString(
            string: "Сообщение получателю",
            attributes: messageTextFieldplaceholderAttributes)
        messageTextField.textColor = UIColor.black
        moneyTextField.textColor = .black
        moneyTextField.font = UIFont.systemFont(ofSize: 32)
        moneyTextField.text = "0"
        moneyTextField.textAlignment = .center
        let resiverNumberPlaceholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.mediumGrayColor,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        resiverNumberTextField.attributedPlaceholder = NSAttributedString(
            string: "Телефон получателя",
            attributes: resiverNumberPlaceholderAttributes)
        resiverNumberTextField.textColor = UIColor.black
        cardImage.image = UIImage(named: "CardIcon")
        arrowImage.image = UIImage(named: "DownArrow")
        commissionLabel.text = "Комиссия 0 ₸"
        commissionLabel.font = UIFont.systemFont(ofSize: 14)
        commissionLabel.textColor = .mediumGrayColor
        moneyErrorLabel.font = UIFont.systemFont(ofSize: 12)
        moneyErrorLabel.textColor = .red
        moneyErrorLabel.text = "Вы не указали сумму перевода"
        phoneErrorLabel.font = UIFont.systemFont(ofSize: 12)
        phoneErrorLabel.textColor = .red
        phoneErrorLabel.text = "Вы не указали номер телефона"
        resiverNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        resiverNameLabel.textColor = .white
        resiverNameLabel.text = "Имя Ф."
        resiverDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 12)
        resiverDescriptionLabel.textColor = .white
        resiverDescriptionLabel.text = "Деньги поступят на карту Kaspi Gold"
        kaspiLabel.text = "Kaspi Gold"
        balanceLabel.text = "123 456,78 ₸"
    }
    private func setupSubviews(_ containerView: UIView) {
        containerView.addSubview(mainView)
        mainView.addSubview(stackView)
        stackView.addArrangedSubview(topView)
        topView.addSubview(cardView)
        cardView.addSubview(cardImage)
        cardView.addSubview(kaspiLabel)
        cardView.addSubview(balanceLabel)
        cardView.addSubview(arrowImage)
        topView.addSubview(segmentController)
        stackView.addArrangedSubview(phoneTextFieldView)
        phoneTextFieldView.addSubview(resiverNumberTextField)
        stackView.addArrangedSubview(phoneErrorView)
        phoneErrorView.addSubview(phoneErrorLabel)
        stackView.addArrangedSubview(resiverView)
        resiverView.addSubview(resiverNameLabel)
        stackView.addArrangedSubview(moneyTextView)
        resiverView.addSubview(resiverDescriptionLabel)
        moneyTextView.addSubview(moneyTFView)
        moneyTFView.addSubview(moneyTextField)
        stackView.addArrangedSubview(moneyErrorView)
        moneyErrorView.addSubview(moneyErrorLabel)
        stackView.addArrangedSubview(messageView)
        messageView.addSubview(messageTFView)
        messageTFView.addSubview(messageTextField)
        messageView.addSubview(profileImageView)
        stackView.addArrangedSubview(bottomView)
        bottomView.addSubview(commissionLabel)
    }
    private func setupConstraints(_ containerView: UIView) {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: mainView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 165),
            cardView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 12),
            cardView.heightAnchor.constraint(equalToConstant: 76),
            cardView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
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
            phoneTextFieldView.heightAnchor.constraint(equalToConstant: 64),
            resiverNumberTextField.centerYAnchor.constraint(equalTo: phoneTextFieldView.centerYAnchor),
            resiverNumberTextField.leadingAnchor.constraint(equalTo: phoneTextFieldView.leadingAnchor, constant: 16),
            phoneErrorView.heightAnchor.constraint(equalToConstant: 16),
            phoneErrorLabel.topAnchor.constraint(equalTo: phoneErrorView.topAnchor, constant: 8),
            phoneErrorLabel.leadingAnchor.constraint(equalTo: phoneErrorView.leadingAnchor, constant: 16),
            resiverView.heightAnchor.constraint(equalToConstant: 64),
            resiverNameLabel.topAnchor.constraint(equalTo: resiverView.topAnchor, constant: 16),
            resiverNameLabel.leadingAnchor.constraint(equalTo: resiverView.leadingAnchor, constant: 16),
            resiverDescriptionLabel.bottomAnchor.constraint(equalTo: resiverView.bottomAnchor, constant: -10),
            resiverDescriptionLabel.leadingAnchor.constraint(equalTo: resiverView.leadingAnchor, constant: 16),
            moneyTextView.heightAnchor.constraint(equalToConstant: 92),
            moneyTFView.topAnchor.constraint(equalTo: moneyTextView.topAnchor, constant: 24),
            moneyTFView.bottomAnchor.constraint(equalTo: moneyTextView.bottomAnchor),
            moneyTFView.leadingAnchor.constraint(equalTo: moneyTextView.leadingAnchor),
            moneyTFView.trailingAnchor.constraint(equalTo: moneyTextView.trailingAnchor),
            moneyTextField.topAnchor.constraint(equalTo: moneyTFView.topAnchor, constant: 10),
            moneyTextField.bottomAnchor.constraint(equalTo: moneyTFView.bottomAnchor, constant: -10),
            moneyTextField.leadingAnchor.constraint(equalTo: moneyTFView.leadingAnchor, constant: 8),
            moneyTextField.trailingAnchor.constraint(equalTo: moneyTFView.trailingAnchor, constant: -8),
            moneyErrorView.heightAnchor.constraint(equalToConstant: 16),
            moneyErrorLabel.topAnchor.constraint(equalTo: moneyErrorView.topAnchor, constant: 8),
            moneyErrorLabel.centerXAnchor.constraint(equalTo: moneyErrorView.centerXAnchor),
            messageView.heightAnchor.constraint(equalToConstant: 126),
            messageTFView.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 16),
            messageTFView.heightAnchor.constraint(equalToConstant: 72),
            messageTFView.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: 16),
            messageTFView.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: -73),
            messageTextField.leadingAnchor.constraint(equalTo: messageTFView.leadingAnchor, constant: 16),
            messageTextField.centerYAnchor.constraint(equalTo: messageTFView.centerYAnchor, constant: 0),
            profileImageView.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 48),
            profileImageView.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: -16),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            bottomView.heightAnchor.constraint(equalToConstant: 118),
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
            contactButton.widthAnchor.constraint(equalToConstant: 50)
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
            confirmationButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor)
        ])
        confirmationButton.addTarget(nil, action: action, for: .touchUpInside)
    }
    func setupThanksButton(in action: Selector) {
        messageView.addSubview(thanksButton)
        NSLayoutConstraint.activate([
            thanksButton.topAnchor.constraint(equalTo: messageTFView.bottomAnchor, constant: 16),
            thanksButton.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: 16)
        ])
        thanksButton.addTarget(nil, action: action, for: .touchUpInside)
    }
    func setupForLunchButton(in action: Selector) {
        messageView.addSubview(forLunchButton)
        NSLayoutConstraint.activate([
            forLunchButton.topAnchor.constraint(equalTo: messageTFView.bottomAnchor, constant: 16),
            forLunchButton.leadingAnchor.constraint(equalTo: thanksButton.trailingAnchor, constant: 8)
        ])
        forLunchButton.addTarget(nil, action: action, for: .touchUpInside)
    }
    func setupReturningButton(in action: Selector) {
        messageView.addSubview(returningButton)
        NSLayoutConstraint.activate([
            returningButton.topAnchor.constraint(equalTo: messageTFView.bottomAnchor, constant: 16),
            returningButton.leadingAnchor.constraint(equalTo: forLunchButton.trailingAnchor, constant: 8)
        ])
        returningButton.addTarget(nil, action: action, for: .touchUpInside)
    }
    func moneyErrorDealer(_ isError: Bool) {
        if isError {
            moneyTFView.layer.borderColor = UIColor.red.cgColor
            moneyTFView.layer.borderWidth = 0.5
            moneyErrorView.isHidden = false
        } else {
            moneyTFView.layer.borderWidth = 0
            moneyErrorView.isHidden = true
        }
    }
    func phoneErrorDealer(_ isError: Bool) {
        if isError {
            phoneTextFieldView.layer.borderColor = UIColor.red.cgColor
            phoneTextFieldView.layer.borderWidth = 0.5
            phoneErrorView.isHidden = false
        } else {
            phoneTextFieldView.layer.borderWidth = 0
            phoneErrorView.isHidden = true
        }
    }
    func roundProfileImage() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
    }
    func resiverViewPopUp(_ number: String, _ name: String) {
        resiverView.isHidden = false
        resiverNumberTextField.text = number
        resiverNameLabel.text = name
    }
    func getResiverNumberTextField() -> UITextField {
        return resiverNumberTextField
    }
    func getMoneyTextField() -> UITextField {
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
    func setConfirmationButtonTitle(_ title: String) {
        confirmationButton.setTitle(title, for: .normal)
    }
    func setMessageTextField(_ text: String) {
            messageTextField.text = text
        }
    func setMoneyErrorLabel(_ text: String) {
        moneyErrorLabel.text = text
    }
    func setPhoneErrorLabel(_ text: String) {
        phoneErrorLabel.text = text
    }
}
