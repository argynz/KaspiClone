import UIKit

class CustomButton: UIButton {
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .red 
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let customSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(withTitle title: String, subtitle: String?, systemIconName: String) {
        iconImageView.image = UIImage(systemName: systemIconName)
        mainTitleLabel.text = title
        if subtitle == nil {
            setupButtonWithoutSubtitle()
        } else {
            customSubtitleLabel.text = subtitle
            setupButtonWithSubtitle()
        }
    }
    
    private func setupButtonWithoutSubtitle() {
        addSubview(iconImageView)
        addSubview(mainTitleLabel)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            mainTitleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            mainTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupButtonWithSubtitle() {
        addSubview(iconImageView)
        addSubview(mainTitleLabel)
        addSubview(customSubtitleLabel)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        customSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            mainTitleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            mainTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -8),
            
            customSubtitleLabel.leadingAnchor.constraint(equalTo: mainTitleLabel.leadingAnchor),
            customSubtitleLabel.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 2),
            customSubtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func updateTitle(to newTitle: String) {
            mainTitleLabel.text = newTitle
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
