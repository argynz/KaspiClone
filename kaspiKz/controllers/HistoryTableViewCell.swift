import UIKit

class HistoryTableViewCell: UITableViewCell {
    static let identifier = "customCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Constants.lightGrayColor
        setupView()
    }
    
    func setupView(){
        self.addSubview(dateLabel)
        mainView.addSubview(avatarView)
        mainView.addSubview(kaspiGoldTitle)
        mainView.addSubview(arrow)
        mainView.addSubview(nameTitle)
        mainView.addSubview(transferAmount)
        mainView.addSubview(smallLabel)
        mainView.addSubview(messageLabel)
        self.addSubview(mainView)
        setupConstraints()
    }
    
    private let transferAmount:UILabel = {
        let label = UILabel()
        label.text = "1 123,45 ₸"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let smallLabel:UILabel = {
        let label = UILabel()
        label.text = "Клиенту Kaspi"
        label.textColor = Constants.mediumGrayColor
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTitle:UILabel = {
        let label = UILabel()
        label.text = "Аскар К."
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrow: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "rightArrow")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let kaspiGoldTitle:UILabel = {
        let label = UILabel()
        label.text = "Kaspi Gold"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let avatarView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "TrasferIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateLabel:UILabel = {
        let label = UILabel()
        label.text = "15 декабря"
        label.textColor = Constants.mediumGrayColor
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let messageLabel:UILabel = {
        let label = PaddingLabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.backgroundColor = Constants.mediumGrayColor
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.preferredMaxLayoutWidth = 199.0
        label.textAlignment = .center
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: smallLabel.centerYAnchor),
            messageLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 16),
            dateLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 16),
            
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainView.leftAnchor.constraint(equalTo: self.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: self.rightAnchor),
            mainView.heightAnchor.constraint(equalToConstant: 88),
            
            avatarView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 12),
            avatarView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16),
            avatarView.widthAnchor.constraint(equalToConstant: 40),
            avatarView.heightAnchor.constraint(equalToConstant: 40),
            
            kaspiGoldTitle.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 12),
            kaspiGoldTitle.leftAnchor.constraint(equalTo: avatarView.rightAnchor, constant: 12),
            
            arrow.topAnchor.constraint(equalTo: kaspiGoldTitle.bottomAnchor, constant: 2),
            arrow.leftAnchor.constraint(equalTo: avatarView.rightAnchor, constant: 12),
            arrow.widthAnchor.constraint(equalToConstant: 24),
            arrow.heightAnchor.constraint(equalToConstant: 24),
            
            nameTitle.topAnchor.constraint(equalTo: kaspiGoldTitle.bottomAnchor, constant: 4),
            nameTitle.leftAnchor.constraint(equalTo: arrow.rightAnchor, constant: 6),
            
            transferAmount.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 12),
            transferAmount.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -16),
            
            smallLabel.topAnchor.constraint(equalTo: arrow.bottomAnchor, constant: 2),
            smallLabel.leftAnchor.constraint(equalTo: avatarView.rightAnchor, constant: 12)
        ])
    }
    
    func configure(with transaction: Transactions) {
        nameTitle.text = transaction.name
        transferAmount.text = transaction.money
        dateLabel.text = convertDateToDayMonthString(date: transaction.date!)
        
        if let message = transaction.message{
            messageLabel.isHidden = false
            messageLabel.text = message
        }else{
            messageLabel.isHidden = true
        }
    }
    
    private func convertDateToDayMonthString(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date)
    }
}
class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 15.0
    @IBInspectable var rightInset: CGFloat = 15.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
