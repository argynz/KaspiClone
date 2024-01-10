import UIKit
class TransferSuccessViewController: UIViewController{
    var name = String()
    var money = String()
    
    private var mainView: UIView = {
        let mainView = UIView()
        mainView.backgroundColor = Constants.lightGrayColor
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    private var topView: UIView = {
        let topView = UIView()
        topView.backgroundColor = Constants.customGreenColor
        topView.translatesAutoresizingMaskIntoConstraints = false
        return topView
    }()
    
    private lazy var transferDiscriptionLabel: UILabel = {
        let transferDiscriptionLabel = UILabel()
        transferDiscriptionLabel.text = "Ваш перевод совершен."
        transferDiscriptionLabel.font = UIFont.boldSystemFont(ofSize: 22)
        transferDiscriptionLabel.textColor = .white
        transferDiscriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return transferDiscriptionLabel
    }()
    
    private lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.text = money
        moneyLabel.font = UIFont.boldSystemFont(ofSize: 48)
        moneyLabel.textColor = .white
        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        return moneyLabel
    }()
    
    private var middleView: UIView = {
        let middleView = UIView()
        middleView.backgroundColor = .white
        middleView.translatesAutoresizingMaskIntoConstraints = false
        return middleView
    }()
    
    private var invoiceLabel: UILabel = {
        let transferDiscriptionLabel = UILabel()
        transferDiscriptionLabel.text = "Показать квитанцию"
        transferDiscriptionLabel.font = UIFont.systemFont(ofSize: 18)
        transferDiscriptionLabel.textColor = Constants.customBlueColor
        transferDiscriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return transferDiscriptionLabel
    }()
    
    private var invoiceDiscriptionLabel: UILabel = {
        let transferDiscriptionLabel = UILabel()
        transferDiscriptionLabel.text = "Квитанция сохранена в Истории"
        transferDiscriptionLabel.font = UIFont.systemFont(ofSize: 12)
        transferDiscriptionLabel.textColor = Constants.mediumGrayColor
        transferDiscriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return transferDiscriptionLabel
    }()
    
    private var invoiceButton: UIButton = {
        let confirmationButton = UIButton()
        confirmationButton.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        confirmationButton.tintColor = .gray
        confirmationButton.translatesAutoresizingMaskIntoConstraints = false
        return confirmationButton
    }()
    
    private var bottomView: UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = .white
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        return bottomView
    }()
    
    private lazy var nameLabel: UILabel = {
        let transferDiscriptionLabel = UILabel()
        transferDiscriptionLabel.text = name
        transferDiscriptionLabel.font = UIFont.systemFont(ofSize: 18)
        transferDiscriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return transferDiscriptionLabel
    }()
    
    private var addToFavLabel: UILabel = {
        let transferDiscriptionLabel = UILabel()
        transferDiscriptionLabel.text = "Сохранить в Частые"
        transferDiscriptionLabel.font = UIFont.systemFont(ofSize: 12)
        transferDiscriptionLabel.textColor = Constants.customBlueColor
        transferDiscriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return transferDiscriptionLabel
    }()
    
    private var addToFavSwitch: UISwitch = {
        let addToFavSwitch = UISwitch()
        addToFavSwitch.translatesAutoresizingMaskIntoConstraints = false
        return addToFavSwitch
    }()
    
    private var backButton: UIButton = {
        let backButton = UIButton()
        backButton.setTitle("Вернуться в Переводы", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.backgroundColor = Constants.customBlueColor
        backButton.layer.cornerRadius = 6
        backButton.clipsToBounds = true
        backButton.addTarget(nil, action: #selector(confirmationButtonPressed), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        setupConstraints()
    }
    private func setupSubViews(){
        view.addSubview(mainView)
        mainView.addSubview(topView)
        topView.addSubview(transferDiscriptionLabel)
        topView.addSubview(moneyLabel)
        mainView.addSubview(middleView)
        middleView.addSubview(invoiceLabel)
        middleView.addSubview(invoiceDiscriptionLabel)
        middleView.addSubview(invoiceButton)
        mainView.addSubview(bottomView)
        bottomView.addSubview(nameLabel)
        bottomView.addSubview(addToFavLabel)
        bottomView.addSubview(addToFavSwitch)
        mainView.addSubview(backButton)
        
    }
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            topView.topAnchor.constraint(equalTo: mainView.topAnchor),
            topView.heightAnchor.constraint(equalToConstant: 162),
            topView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            
            transferDiscriptionLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 12),
            transferDiscriptionLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            
            moneyLabel.topAnchor.constraint(equalTo: transferDiscriptionLabel.bottomAnchor, constant: 12),
            moneyLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            
            middleView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 1),
            middleView.heightAnchor.constraint(equalToConstant: 64),
            middleView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            middleView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            
            invoiceLabel.topAnchor.constraint(equalTo: middleView.topAnchor, constant: 12),
            invoiceLabel.leadingAnchor.constraint(equalTo: middleView.leadingAnchor, constant: 16),
            
            invoiceDiscriptionLabel.topAnchor.constraint(equalTo: invoiceLabel.bottomAnchor, constant: 4),
            invoiceDiscriptionLabel.leadingAnchor.constraint(equalTo: middleView.leadingAnchor, constant: 16),
            
            invoiceButton.trailingAnchor.constraint(equalTo: middleView.trailingAnchor, constant: -16),
            invoiceButton.centerYAnchor.constraint(equalTo: middleView.centerYAnchor),
            invoiceButton.heightAnchor.constraint(equalToConstant: 35),
            invoiceButton.widthAnchor.constraint(equalToConstant: 40),
            
            bottomView.topAnchor.constraint(equalTo: middleView.bottomAnchor, constant: 1),
            bottomView.heightAnchor.constraint(equalToConstant: 64),
            bottomView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            
            addToFavLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            addToFavLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            
            addToFavSwitch.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            addToFavSwitch.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            
            backButton.heightAnchor.constraint(equalToConstant: 60),
            backButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            backButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            backButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16)
        ])
    }
    @objc private func confirmationButtonPressed() {
        self.dismiss(animated: true)
    }
}
