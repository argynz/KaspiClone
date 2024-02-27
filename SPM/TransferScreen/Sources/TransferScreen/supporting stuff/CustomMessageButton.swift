import UIKit

class CustomMessageButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        
        var config = UIButton.Configuration.filled()
        config.title = title
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .black
        config.cornerStyle = .capsule
        config.titlePadding = 8
        config.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10)
        let titleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        config.attributedTitle = AttributedString(title, attributes: AttributeContainer(titleAttributes))
        
        self.configuration = config
        self.layer.cornerRadius = 14
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.gray.cgColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
