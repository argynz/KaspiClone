import UIKit

class HistoryPageView {
    var segmentController: UISegmentedControl = {
        let segmentController = UISegmentedControl(items: ["ПЕРЕВОДЫ", "ИСТОРИЯ"])
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
        segmentController.translatesAutoresizingMaskIntoConstraints = false
        return segmentController
    }()
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var mainView: UIView = {
        let mainView = UIView()
        mainView.backgroundColor = Colors.lightGrayColor
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var betweenAccounts: CustomButton = {
        let customButton = CustomButton(frame: .zero)
        customButton.configure(withTitle: "Между своими счетами", subtitle: nil, systemIconName: "repeat")
        customButton.backgroundColor = .white
        customButton.translatesAutoresizingMaskIntoConstraints = false
        return customButton
    }()
    
    var toClientKaspi: CustomButton = {
        let customButton = CustomButton(frame: .zero)
        customButton.configure(withTitle: "Клиенту каспи", subtitle: "На карту Kaspi Gold", systemIconName: "person")
        customButton.backgroundColor = .white
        customButton.translatesAutoresizingMaskIntoConstraints = false
        return customButton
    }()
    
    private var toCard: CustomButton = {
        let customButton = CustomButton(frame: .zero)
        customButton.configure(withTitle: "Карта другого банка", 
                               subtitle: "С карты на карту",
                               systemIconName: "creditcard.circle")
        customButton.backgroundColor = .white
        customButton.translatesAutoresizingMaskIntoConstraints = false
        return customButton
    }()
    
    private var internationalTransfer: CustomButton = {
        let customButton = CustomButton(frame: .zero)
        customButton.configure(withTitle: "Международные переводы", 
                               subtitle: "По номеру карты или телефона ",
                               systemIconName: "globe")
        customButton.backgroundColor = .white
        customButton.translatesAutoresizingMaskIntoConstraints = false
        return customButton
    }()
    
    private var kaspiQR: CustomButton = {
        let customButton = CustomButton(frame: .zero)
        customButton.configure(withTitle: "Kaspi QR", subtitle: "Сканируйте и платите", systemIconName: "qrcode")
        customButton.backgroundColor = .white
        customButton.translatesAutoresizingMaskIntoConstraints = false
        return customButton
    }()
    
    private var transferHistoryView: UIView = {
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    private var searchBarView: UIView = {
        let mainView = UIView()
        mainView.backgroundColor = .white
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    private var searchImg: UIImageView = {
        let searchImg  = UIImageView()
        searchImg.image = UIImage(systemName: "magnifyingglass")
        searchImg.tintColor = .red
        searchImg.translatesAutoresizingMaskIntoConstraints = false
        return searchImg
    }()
    
    var searchTextField: UITextField = {
        let searchTextField  = UITextField()
        let searchTextFieldplaceholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Colors.mediumGrayColor,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Имя, сумма, сообщение", 
                                                                   attributes: searchTextFieldplaceholderAttributes)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        return searchTextField
    }()
    
    lazy var calendarButton: CustomButton = {
        let customButton = CustomButton(frame: .zero)
        customButton.configure(withTitle: convertDateToDayMonthString(date: Date()), 
                               subtitle: nil, systemIconName: "calendar")
        customButton.backgroundColor = .white
        customButton.translatesAutoresizingMaskIntoConstraints = false
        return customButton
    }()
    
    let calendarViewController: UIViewController = {
        let calendarViewController = UIViewController()
        calendarViewController.modalPresentationStyle = .overCurrentContext
        return calendarViewController
    }()
    
    let calendar: UICalendarView = {
        let calendar = UICalendarView()
        calendar.backgroundColor = .white
        calendar.frame = CGRect(x: 45, y: 200, width: 303, height: 303)
        calendar.layer.borderWidth = 1
        calendar.layer.borderColor = Colors.mediumGrayColor.cgColor
        calendar.layer.cornerRadius = 8
        calendar.tintColor = .red
        calendar.locale = .current
        return calendar
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private func setupSubviews(_ containerView: UIView) {
        containerView.addSubview(segmentController)
        containerView.addSubview(scrollView)
        scrollView.addSubview(mainView)
        scrollView.addSubview(transferHistoryView)
        mainView.addSubview(stackView)
        stackView.addArrangedSubview(betweenAccounts)
        stackView.addArrangedSubview(toClientKaspi)
        stackView.addArrangedSubview(toCard)
        stackView.addArrangedSubview(internationalTransfer)
        stackView.addArrangedSubview(kaspiQR)
        transferHistoryView.addSubview(searchBarView)
        searchBarView.addSubview(searchImg)
        searchBarView.addSubview(searchTextField)
        transferHistoryView.addSubview(calendarButton)
        transferHistoryView.addSubview(tableView)
    }
    
    private func setupConstraints(_ containerView: UIView) {
        NSLayoutConstraint.activate([
            scrollView.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 618),
            
            segmentController.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 8),
            segmentController.leadingAnchor.constraint(
                equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            segmentController.trailingAnchor.constraint(
                equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            segmentController.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant: -8),
            
            mainView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainView.heightAnchor.constraint(equalToConstant: 618),
            mainView.widthAnchor.constraint(equalToConstant: 786),
            mainView.heightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.heightAnchor),
            
            transferHistoryView.topAnchor.constraint(equalTo: mainView.topAnchor),
            transferHistoryView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            transferHistoryView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            transferHistoryView.widthAnchor.constraint(equalToConstant: 393),
            
            stackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: transferHistoryView.leadingAnchor),
            
            betweenAccounts.heightAnchor.constraint(equalToConstant: 64),
            toClientKaspi.heightAnchor.constraint(equalToConstant: 64),
            toCard.heightAnchor.constraint(equalToConstant: 64),
            internationalTransfer.heightAnchor.constraint(equalToConstant: 64),
            kaspiQR.heightAnchor.constraint(equalToConstant: 64),
            
            searchBarView.topAnchor.constraint(equalTo: transferHistoryView.topAnchor, constant: 8),
            searchBarView.leadingAnchor.constraint(equalTo: transferHistoryView.leadingAnchor, constant: 8),
            searchBarView.trailingAnchor.constraint(equalTo: transferHistoryView.trailingAnchor, constant: -8),
            searchBarView.heightAnchor.constraint(equalToConstant: 48),
            
            searchImg.heightAnchor.constraint(equalToConstant: 21),
            searchImg.widthAnchor.constraint(equalToConstant: 20),
            searchImg.leadingAnchor.constraint(equalTo: searchBarView.leadingAnchor, constant: 8),
            searchImg.centerYAnchor.constraint(equalTo: searchBarView.centerYAnchor),
            
            searchTextField.centerYAnchor.constraint(equalTo: searchBarView.centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: searchImg.trailingAnchor, constant: 6),
            
            calendarButton.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 8),
            calendarButton.leadingAnchor.constraint(equalTo: transferHistoryView.leadingAnchor),
            calendarButton.trailingAnchor.constraint(equalTo: transferHistoryView.trailingAnchor),
            calendarButton.heightAnchor.constraint(equalToConstant: 56),
            
            tableView.leadingAnchor.constraint(equalTo: transferHistoryView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: transferHistoryView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: transferHistoryView.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: calendarButton.bottomAnchor)
        ])
    }
    
    func setupUI(_ containerView: UIView) {
        setupSubviews(containerView)
        setupConstraints(containerView)
    }
    
    func setupCalendar() {
        let someView = UIView()
        someView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        calendarViewController.popoverPresentationController?.sourceView = self.calendarButton
        calendarViewController.popoverPresentationController?.sourceRect = self.calendarButton.bounds
        calendarViewController.view.addSubview(someView)
        calendarViewController.view.addSubview(calendar)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutside(_:)))
        someView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTapOutside(_ sender: UITapGestureRecognizer) {
        calendarViewController.dismiss(animated: true)
    }

    private func convertDateToDayMonthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return "... - " + dateFormatter.string(from: date)
    }
}
