import UIKit

class ProfilePageView {
    
    private let userDefaults = UserDefaults.standard
    
    private var mainView: UIView = {
        let mainView = UIView()
        mainView.backgroundColor = Colors.lightGrayColor
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    private var topView: UIView = {
        let topView = UIView()
        topView.backgroundColor = Colors.darkGrayColor
        topView.translatesAutoresizingMaskIntoConstraints = false
        return topView
    }()
    
    lazy var profileImageView: UIImageView = {
        var profileImageView = UIImageView()
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.clear.cgColor
        profileImageView.clipsToBounds = true
        profileImageView.image = UIImage(
            data: (userDefaults.data(forKey: "PhotoData") ?? UIImage(named: "Icon")?.pngData())!)
        profileImageView.isUserInteractionEnabled = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        return profileImageView
    }()
    
    private var cameraImgBg: UIImageView = {
        let cameraImgBg = UIImageView()
        cameraImgBg.image = UIImage(systemName: "circle.fill")
        cameraImgBg.tintColor = .red
        cameraImgBg.translatesAutoresizingMaskIntoConstraints = false
        return cameraImgBg
    }()
    
    private var cameraImg: UIImageView = {
        let cameraImg = UIImageView()
        cameraImg.image = UIImage(named: "Camera")
        cameraImg.tintColor = .white
        cameraImg.translatesAutoresizingMaskIntoConstraints = false
        return cameraImg
    }()
    
    var loadingIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.color = .white
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        return loadingIndicator
    }()
    
    var randomImgButton: UIButton = {
        let randomImgButton = UIButton()
        randomImgButton.setTitle("RANDOM PHOTO", for: .normal)
        randomImgButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 8)
        randomImgButton.backgroundColor = .red
        randomImgButton.setTitleColor(.white, for: .normal)
        randomImgButton.layer.cornerRadius = 10
        randomImgButton.translatesAutoresizingMaskIntoConstraints = false
        return randomImgButton
    }()
    
    private var nameView: UIView = {
        let nameView = UIView()
        nameView.backgroundColor = .white
        nameView.translatesAutoresizingMaskIntoConstraints = false
        return nameView
    }()
    
    lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.text = userDefaults.string(forKey: "Name")
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        return nameTextField
    }()
    
    var noneEditableNameLabel: UILabel = {
        let noneEditableNameLabel = UILabel()
        noneEditableNameLabel.text = "Имя:"
        noneEditableNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        noneEditableNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return noneEditableNameLabel
    }()
    
    lazy var editableNameLabel: UILabel = {
        let editableNameLabel = UILabel()
        editableNameLabel.text = userDefaults.string(forKey: "Name")
        editableNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return editableNameLabel
    }()
    
    var nameEditButton: UIButton = {
        let nameEditButton = UIButton()
        nameEditButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        nameEditButton.tintColor = .black
        nameEditButton.translatesAutoresizingMaskIntoConstraints = false
        return nameEditButton
    }()
    
    private var surnameView: UIView = {
        let surnameView = UIView()
        surnameView.backgroundColor = .white
        surnameView.translatesAutoresizingMaskIntoConstraints = false
        return surnameView
    }()
    
    lazy var surnameTextField: UITextField = {
        let surnameTextField = UITextField()
        surnameTextField.text = userDefaults.string(forKey: "Surname")
        surnameTextField.translatesAutoresizingMaskIntoConstraints = false
        return surnameTextField
    }()
    
    var noneEditableSurnameLabel: UILabel = {
        let noneEditableSurnameLabel = UILabel()
        noneEditableSurnameLabel.text = "Фамилия:"
        noneEditableSurnameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        noneEditableSurnameLabel.translatesAutoresizingMaskIntoConstraints = false
        return noneEditableSurnameLabel
    }()
    
    lazy var editableSurnameLabel: UILabel = {
        let editableSurnameLabel = UILabel()
        editableSurnameLabel.text = userDefaults.string(forKey: "Surname")
        editableSurnameLabel.translatesAutoresizingMaskIntoConstraints = false
        return editableSurnameLabel
    }()
    
    var surnameEditButton: UIButton = {
        let surnameEditButton = UIButton()
        surnameEditButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        surnameEditButton.tintColor = .black
        surnameEditButton.translatesAutoresizingMaskIntoConstraints = false
        return surnameEditButton
    }()
    
    private func setupSubviews(_ containerView: UIView) {
        containerView.addSubview(mainView)
        mainView.addSubview(topView)
        topView.addSubview(profileImageView)
        topView.addSubview(cameraImgBg)
        topView.addSubview(cameraImg)
        topView.addSubview(loadingIndicator)
        topView.addSubview(randomImgButton)
        mainView.addSubview(nameView)
        nameView.addSubview(nameTextField)
        nameView.addSubview(noneEditableNameLabel)
        nameView.addSubview(editableNameLabel)
        nameView.addSubview(nameEditButton)
        mainView.addSubview(surnameView)
        surnameView.addSubview(surnameTextField)
        surnameView.addSubview(noneEditableSurnameLabel)
        surnameView.addSubview(editableSurnameLabel)
        surnameView.addSubview(surnameEditButton)
    }
    
    private func setupConstraints(_ containerView: UIView) {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor),
            
            topView.topAnchor.constraint(equalTo: mainView.topAnchor),
            topView.heightAnchor.constraint(equalToConstant: 164),
            topView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            
            cameraImgBg.heightAnchor.constraint(equalToConstant: 27),
            cameraImgBg.widthAnchor.constraint(equalToConstant: 27),
            cameraImgBg.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            cameraImgBg.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 3),
            
            cameraImg.heightAnchor.constraint(equalToConstant: 21),
            cameraImg.widthAnchor.constraint(equalToConstant: 21),
            cameraImg.centerXAnchor.constraint(equalTo: cameraImgBg.centerXAnchor),
            cameraImg.centerYAnchor.constraint(equalTo: cameraImgBg.centerYAnchor),
            
            randomImgButton.heightAnchor.constraint(equalToConstant: 24),
            randomImgButton.widthAnchor.constraint(equalToConstant: 92),
            randomImgButton.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -8),
            randomImgButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8),
            
            nameView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 16),
            nameView.heightAnchor.constraint(equalToConstant: 64),
            nameView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            nameView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            
            nameTextField.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: 16),
            nameTextField.centerYAnchor.constraint(equalTo: nameView.centerYAnchor),
            
            noneEditableNameLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: 16),
            noneEditableNameLabel.centerYAnchor.constraint(equalTo: nameView.centerYAnchor),
            
            editableNameLabel.leadingAnchor.constraint(equalTo: noneEditableNameLabel.trailingAnchor, constant: 6),
            editableNameLabel.centerYAnchor.constraint(equalTo: nameView.centerYAnchor),
            
            nameEditButton.trailingAnchor.constraint(equalTo: nameView.trailingAnchor, constant: -16),
            nameEditButton.centerYAnchor.constraint(equalTo: nameView.centerYAnchor),
            nameEditButton.heightAnchor.constraint(equalToConstant: 35),
            nameEditButton.widthAnchor.constraint(equalToConstant: 46),
            
            surnameView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 16),
            surnameView.heightAnchor.constraint(equalToConstant: 64),
            surnameView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            surnameView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            
            surnameTextField.leadingAnchor.constraint(equalTo: surnameView.leadingAnchor, constant: 16),
            surnameTextField.centerYAnchor.constraint(equalTo: surnameView.centerYAnchor),
            
            noneEditableSurnameLabel.leadingAnchor.constraint(equalTo: surnameView.leadingAnchor, constant: 16),
            noneEditableSurnameLabel.centerYAnchor.constraint(equalTo: surnameView.centerYAnchor),
            
            editableSurnameLabel.leadingAnchor.constraint(
                equalTo: noneEditableSurnameLabel.trailingAnchor, constant: 6),
            editableSurnameLabel.centerYAnchor.constraint(equalTo: surnameView.centerYAnchor),
            
            surnameEditButton.trailingAnchor.constraint(equalTo: surnameView.trailingAnchor, constant: -16),
            surnameEditButton.centerYAnchor.constraint(equalTo: surnameView.centerYAnchor),
            surnameEditButton.heightAnchor.constraint(equalToConstant: 35),
            surnameEditButton.widthAnchor.constraint(equalToConstant: 46)
        ])
    }
    
    func setupUI(_ containerView: UIView) {
        setupSubviews(containerView)
        setupConstraints(containerView)
        nameTextField.isHidden = true
        surnameTextField.isHidden = true
        loadingIndicator.isHidden = true
    }
}
