import UIKit
import CoreData

class SegmentViewControler: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControler: UISegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!

    
    var transactions: [Transactions] = []
    var filteredTransactions: [Transactions] = []
    
    var isDateFiltering: Bool = false

    var isSearching: Bool {
        let isSearchTextEmpty = searchTextField.text?.isEmpty ?? true
        return !isSearchTextEmpty || isDateFiltering
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        tableView.dataSource = self
        searchTextField.delegate = self
        fetchTransactions()
    }
    
    //MARK: SegmentControler
    @IBAction func segmentControler(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        case 1:
            scrollView.setContentOffset(CGPoint(x: 393, y: 0), animated: true)
        default:
            print("Error")
        }
    }
    
    //MARK: FetchTransactions from CoreData
    func fetchTransactions() {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedObjectContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<Transactions>(entityName: "Transactions")

            do {
                transactions = try managedObjectContext.fetch(fetchRequest)
                tableView.reloadData()
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    
    //MARK: Calendar
    func updateButtonTitle(startDate: Date, endDate: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")

        let startDateString = dateFormatter.string(from: startDate)
        let endDateString = dateFormatter.string(from: endDate)

        calendarButton.setTitle("\(startDateString) - \(endDateString)", for: .normal)
    }
    func filterTransactionsByDateRange(startDate: Date, endDate: Date) {
        
        isDateFiltering = true
        
        let filteredByDate = transactions.filter { transaction in
            guard let transactionDate = transaction.date else { return false }
            let calendar = Calendar.current
            let adjustedEndDate = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: endDate) ?? endDate
            return transactionDate >= startDate && transactionDate <= adjustedEndDate
        }
        
        if let searchText = searchTextField.text, !searchText.isEmpty {
            filteredTransactions = filteredByDate.filter { transaction in
                transaction.name?.lowercased().contains(searchText.lowercased()) ?? false
            }
        } else {
            filteredTransactions = filteredByDate
        }
        
        tableView.reloadData()
    }
    @IBAction func calendarButtonTapped(_ sender: UIButton) {
        let calendarViewController = CalendarViewController()
            calendarViewController.modalPresentationStyle = .popover
            calendarViewController.preferredContentSize = CGSize(width: 300, height: 400)
            calendarViewController.popoverPresentationController?.sourceView = sender
            calendarViewController.popoverPresentationController?.sourceRect = sender.bounds

            calendarViewController.onDateRangeSelected = { [weak self] startDate, endDate in
                self?.updateButtonTitle(startDate: startDate, endDate: endDate)
                self?.filterTransactionsByDateRange(startDate: startDate, endDate: endDate)
                self?.dismiss(animated: true, completion: nil)
            }

            present(calendarViewController, animated: true, completion: nil)
    }
    
}

extension SegmentViewControler: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredTransactions.count : transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! HistoryTableViewCell
        
        let transaction = isSearching ? filteredTransactions[indexPath.row] : transactions[indexPath.row]
        
        cell.name.text = transaction.name!
        cell.money.text = transaction.money!
        cell.date.text = convertDateToDayMonthString(date: transaction.date!)
        
        return cell
    }
    
    func convertDateToDayMonthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date)
    }
    
}

extension SegmentViewControler: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder() // Dismiss the keyboard
            performSearch() // Perform search when the user taps the return key
            return true
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            performSearch() // Perform search as the user types
        }

        func performSearch() {
            guard let searchText = searchTextField.text, !searchText.isEmpty else {
                filteredTransactions = transactions
                tableView.reloadData()
                return
            }

            filteredTransactions = transactions.filter { transaction in
                return transaction.name?.lowercased().contains(searchText.lowercased()) ?? false
            }
            tableView.reloadData()
        }
}

extension SegmentViewControler: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(scrollView.contentOffset.x / pageWidth)
                
        segmentControler.selectedSegmentIndex = page
    }
}
