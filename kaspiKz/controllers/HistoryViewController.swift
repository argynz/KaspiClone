import UIKit
import CoreData

class HistoryViewController: UIViewController{
    private var historyPageContent: HistoryPageContent?
    
    private var transactions: [Transactions] = []
    private var filteredTransactions: [Transactions] = []
    
    private var firstDate: Date? = nil
    private var secondDate: Date? = nil
    
    private var isDateFiltering: Bool = false
    
    private var isSearching: Bool {
        let isSearchTextEmpty = historyPageContent?.searchTextField.text?.isEmpty ?? true
        return !isSearchTextEmpty || isDateFiltering
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyPageContent = HistoryPageContent()
        historyPageContent?.setupUI(view)
        setupTargets()
        setupDelegates()
        fetchTransactions()
    }
    
    private func setupTargets(){
        historyPageContent?.segmentController.addTarget(self, action: #selector(segmentControler), for: .valueChanged)
        historyPageContent?.calendarButton.addTarget(self, action: #selector(calendarButtonTapped), for: .touchUpInside)
        historyPageContent?.toClientKaspi.addTarget(self, action: #selector(toClientKaspiPressed), for: .touchUpInside)
    }
    
    private func setupDelegates(){
        historyPageContent?.tableView.delegate = self
        historyPageContent?.scrollView.delegate = self
        historyPageContent?.tableView.dataSource = self
        historyPageContent?.searchTextField.delegate = self
        historyPageContent?.calendar.delegate = self
        
        let dateSelection = UICalendarSelectionMultiDate(delegate: self)
        historyPageContent?.calendar.selectionBehavior = dateSelection
    }
    
    private func setupCalendarDelegates(_ calendar: UICalendarView){
        firstDate = nil
        calendar.delegate = self
        
        let dateSelection = UICalendarSelectionMultiDate(delegate: self)
        calendar.selectionBehavior = dateSelection
    }
    
    //MARK: FetchTransactions from CoreData
    private func fetchTransactions() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Transactions>(entityName: "Transactions")
        
        do {
            transactions = try managedObjectContext.fetch(fetchRequest)
            historyPageContent?.tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: Calendar
    private func updateButtonTitle(startDate: Date, endDate: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let startDateString = dateFormatter.string(from: startDate)
        let endDateString = dateFormatter.string(from: endDate)
        
        historyPageContent?.calendarButton.updateTitle(to: "\(startDateString) - \(endDateString)")
    }
    private func filterTransactionsByDateRange(startDate: Date, endDate: Date) {
        isDateFiltering = true
        
        let filteredByDate = transactions.filter { transaction in
            guard let transactionDate = transaction.date else { return false }
            let calendar = Calendar.current
            let adjustedEndDate = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: endDate) ?? endDate
            return transactionDate >= startDate && transactionDate <= adjustedEndDate
        }
        
        if let searchText = historyPageContent?.searchTextField.text, !searchText.isEmpty {
            filteredTransactions = filteredByDate.filter { transaction in
                transaction.name?.lowercased().contains(searchText.lowercased()) ?? false
            }
        } else {
            filteredTransactions = filteredByDate
        }
        
        historyPageContent?.tableView.reloadData()
    }
    @objc private func calendarButtonTapped(_ sender: CustomButton) {
        setupCalendarDelegates(historyPageContent?.calendar ?? UICalendarView())
        historyPageContent?.setupCalendar()
        self.present(historyPageContent?.calendarViewController ?? UIViewController(), animated: true, completion: nil)
    }
    
    //MARK: SegmentControler
    @objc private func segmentControler(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            historyPageContent?.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        case 1:
            historyPageContent?.scrollView.setContentOffset(CGPoint(x: 393, y: 0), animated: true)
        default:
            print("Error")
        }
    }
    
    //MARK: To Kaspi Client Button Pressed
    @objc private func toClientKaspiPressed(_ sender: UISegmentedControl) {
        let vc = TransferViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredTransactions.count : transactions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as? HistoryTableViewCell else{
            fatalError("The table view could dequeue a Cell")
        }
        let transaction = isSearching ? filteredTransactions[indexPath.row] : transactions[indexPath.row]
        cell.configure(with: transaction)
        return cell
    }
}

extension HistoryViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performSearch()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        performSearch()
    }
    
    func performSearch() {
        guard let searchText = historyPageContent?.searchTextField.text, !searchText.isEmpty else {
            filteredTransactions = transactions
            historyPageContent?.tableView.reloadData()
            return
        }
        filteredTransactions = transactions.filter { transaction in
            return transaction.name?.lowercased().contains(searchText.lowercased()) ?? false
        }
        historyPageContent?.tableView.reloadData()
    }
}

extension HistoryViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y == 0 {
            let width = scrollView.bounds.size.width
            let page = Int((scrollView.contentOffset.x + (0.5 * width)) / width)
            historyPageContent?.segmentController.selectedSegmentIndex = page
        }
    }
}

extension HistoryViewController: UICalendarViewDelegate, UICalendarSelectionMultiDateDelegate{
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        if firstDate == nil{
            firstDate = dateComponents.date
        }else{
            secondDate = dateComponents.date
            filterTransactionsByDateRange(startDate: firstDate ?? Date(), endDate: secondDate ?? Date())
            updateButtonTitle(startDate: firstDate ?? Date(), endDate: secondDate ?? Date())
            historyPageContent?.calendarViewController.dismiss(animated: true)
        }
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        firstDate = nil
    }
}
