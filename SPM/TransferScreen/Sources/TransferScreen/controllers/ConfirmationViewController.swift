import UIKit
import CoreData

class ConfirmationViewController: UIViewController {
    var name = String()
    var money = String()
    var message: String?
    private var mainView: UIView = {
        let mainView = UIView()
        mainView.backgroundColor = .lightGrayColor
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private var topView: UIView = {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        return topView
    }()
    private var cardView: UIView = {
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
    }()
    private var topCardImg: UIImageView = {
        let topCardImg = UIImageView()
        topCardImg.image = UIImage(named: "CardIcon")
        topCardImg.translatesAutoresizingMaskIntoConstraints = false
        return topCardImg
    }()
    private var kaspiLabel: UILabel = {
        let kaspiLabel = UILabel()
        kaspiLabel.text = "Kaspi Gold"
        kaspiLabel.translatesAutoresizingMaskIntoConstraints = false
        return kaspiLabel
    }()
    private var accountLabel: UILabel = {
        let accountLabel = UILabel()
        accountLabel.text = "123 456,78 ₸"
        accountLabel.translatesAutoresizingMaskIntoConstraints = false
        return accountLabel
    }()
    private var arrowImg: UIImageView = {
        let arrowImg = UIImageView()
        arrowImg.image = UIImage(named: "DownArrow")
        arrowImg.translatesAutoresizingMaskIntoConstraints = false
        return arrowImg
    }()
    private var nameView: UIView = {
        let nameView = UIView()
        nameView.backgroundColor = .white
        nameView.translatesAutoresizingMaskIntoConstraints = false
        return nameView
    }()
    private var bottomCardImg: UIImageView = {
        let bottomCardImg = UIImageView()
        bottomCardImg.image = UIImage(named: "CardIcon")
        bottomCardImg.translatesAutoresizingMaskIntoConstraints = false
        return bottomCardImg
    }()
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    private var moneyView: UIView = {
        let moneyView = UIView()
        moneyView.backgroundColor = .white
        moneyView.translatesAutoresizingMaskIntoConstraints = false
        return moneyView
    }()
    private var transferLabel: UILabel = {
        let transferLabel = UILabel()
        transferLabel.text = "Сумма перевода"
        transferLabel.translatesAutoresizingMaskIntoConstraints = false
        return transferLabel
    }()
    private lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.text = money
        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        return moneyLabel
    }()
    private var messageView: UIView = {
        let messageView = UIView()
        messageView.backgroundColor = .white
        messageView.translatesAutoresizingMaskIntoConstraints = false
        return messageView
    }()
    private var messageDiscriptionLabel: UILabel = {
        let messageDiscriptionLabel = UILabel()
        messageDiscriptionLabel.text = "Сообщениу получателю"
        messageDiscriptionLabel.font = UIFont.systemFont(ofSize: 12)
        messageDiscriptionLabel.textColor = .mediumGrayColor
        messageDiscriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return messageDiscriptionLabel
    }()
    private lazy var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        return messageLabel
    }()
    private var bottomView: UIView = {
        let bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        return bottomView
    }()
    private lazy var confirmationButton: UIButton = {
        let confirmationButton = UIButton()
        confirmationButton.setTitle("Подтвердить и перевести " + money, for: .normal)
        confirmationButton.setTitleColor(.white, for: .normal)
        confirmationButton.backgroundColor = .customBlueColor
        confirmationButton.layer.cornerRadius = 6
        confirmationButton.clipsToBounds = true
        confirmationButton.addTarget(nil, action: #selector(confirmationButtonPressed), for: .touchUpInside)
        confirmationButton.translatesAutoresizingMaskIntoConstraints = false
        return confirmationButton
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Переводы"
        navigationItem.style = .editor
        navigationItem.backButtonTitle = ""
        if message == nil {
            messageView.isHidden = true
        }
        setupSubViews()
        setupConstraints()
    }
    private func setupSubViews() {
        view.addSubview(mainView)
        mainView.addSubview(stackView)
        stackView.addArrangedSubview(topView)
        topView.addSubview(cardView)
        cardView.addSubview(topCardImg)
        cardView.addSubview(kaspiLabel)
        cardView.addSubview(accountLabel)
        cardView.addSubview(arrowImg)
        topView.addSubview(nameView)
        nameView.addSubview(bottomCardImg)
        nameView.addSubview(nameLabel)
        topView.addSubview(moneyView)
        moneyView.addSubview(transferLabel)
        moneyView.addSubview(moneyLabel)
        stackView.addArrangedSubview(messageView)
        messageView.addSubview(messageDiscriptionLabel)
        messageView.addSubview(messageLabel)
        stackView.addArrangedSubview(bottomView)
        bottomView.addSubview(confirmationButton)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: mainView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 312),
            cardView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 36),
            cardView.heightAnchor.constraint(equalToConstant: 76),
            cardView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            topCardImg.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            topCardImg.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            topCardImg.heightAnchor.constraint(equalToConstant: 52),
            topCardImg.widthAnchor.constraint(equalToConstant: 52),
            kaspiLabel.leadingAnchor.constraint(equalTo: topCardImg.trailingAnchor, constant: 12),
            kaspiLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            accountLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            accountLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            arrowImg.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 62),
            arrowImg.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            arrowImg.heightAnchor.constraint(equalToConstant: 24),
            arrowImg.widthAnchor.constraint(equalToConstant: 24),
            nameView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 12),
            nameView.heightAnchor.constraint(equalToConstant: 76),
            nameView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            nameView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            bottomCardImg.topAnchor.constraint(equalTo: nameView.topAnchor, constant: 12),
            bottomCardImg.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: 16),
            bottomCardImg.heightAnchor.constraint(equalToConstant: 52),
            bottomCardImg.widthAnchor.constraint(equalToConstant: 52),
            nameLabel.leadingAnchor.constraint(equalTo: bottomCardImg.trailingAnchor, constant: 12),
            nameLabel.centerYAnchor.constraint(equalTo: nameView.centerYAnchor),
            moneyView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 36),
            moneyView.heightAnchor.constraint(equalToConstant: 64),
            moneyView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            moneyView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            transferLabel.leadingAnchor.constraint(equalTo: moneyView.leadingAnchor, constant: 16),
            transferLabel.centerYAnchor.constraint(equalTo: moneyView.centerYAnchor),
            moneyLabel.trailingAnchor.constraint(equalTo: moneyView.trailingAnchor, constant: -16),
            moneyLabel.centerYAnchor.constraint(equalTo: moneyView.centerYAnchor),
            messageView.heightAnchor.constraint(equalToConstant: 64),
            messageDiscriptionLabel.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 12),
            messageDiscriptionLabel.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: 16),
            messageLabel.bottomAnchor.constraint(equalTo: messageView.bottomAnchor, constant: -12),
            messageLabel.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: 16),
            bottomView.heightAnchor.constraint(equalToConstant: 84),
            confirmationButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 24),
            confirmationButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            confirmationButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            confirmationButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor)
        ])
    }
    @objc private func confirmationButtonPressed() {
        let managedObjectContext = CoreDataStack.shared.persistentContainer.viewContext
        let transaction = Transactions(context: managedObjectContext)
        transaction.name = name
        transaction.money = money
        transaction.message = message
        transaction.date = Date()
        do {
            try managedObjectContext.save()
            presentSuccessBottomSheet(name: name, money: money)
        } catch {
            print("Could not save transaction: \(error)")
        }
    }

    private func presentSuccessBottomSheet(name: String, money: String) {
        let bottomSheet = TransferSuccessViewController()
        if let sheet = bottomSheet.sheetPresentationController {
            sheet.detents = [.large(), .medium()]
            sheet.prefersGrabberVisible = true
        }
        bottomSheet.name = name
        bottomSheet.money = money
        self.present(bottomSheet, animated: true)
    }
}
