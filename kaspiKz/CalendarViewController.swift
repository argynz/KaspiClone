import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.dataSource = self
        calendar.delegate = self
        calendar.allowsMultipleSelection = true
        calendar.backgroundColor = UIColor.white
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    var selectedStartDate: Date?
    var selectedEndDate: Date?
    var onDateRangeSelected: ((Date, Date) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI() {
        view.addSubview(calendar)
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor),
            calendar.leftAnchor.constraint(equalTo: view.leftAnchor),
            calendar.rightAnchor.constraint(equalTo: view.rightAnchor),
            calendar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if selectedStartDate == nil {
            selectedStartDate = date
            selectedEndDate = nil
        } else if selectedEndDate == nil && date > selectedStartDate! {
            selectedEndDate = date
            onDateRangeSelected?(selectedStartDate!, selectedEndDate!)
        } else {
            selectedStartDate = date
            selectedEndDate = nil
        }
    }
}
