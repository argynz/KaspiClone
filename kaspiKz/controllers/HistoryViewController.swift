import UIKit
import CoreData

class HistoryViewController: UIViewController{
    private var historyPageView: HistoryPageView?
    
    private var transactions: [Transactions] = []
    private var filteredTransactions: [Transactions] = []
    
    private var firstDate: Date? = nil
    private var secondDate: Date? = nil
    
    private var isDateFiltering: Bool = false
    
    private var isSearching: Bool {
        let isSearchTextEmpty = historyPageView?.searchTextField.text?.isEmpty ?? true
        return !isSearchTextEmpty || isDateFiltering
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyPageView = HistoryPageView()
        historyPageView?.setupUI(view)
        setupTargets()
        setupDelegates()
        fetchTransactions()
    }
    
    private func setupTargets(){
        historyPageView?.segmentController.addTarget(self, action: #selector(segmentControler), for: .valueChanged)
        historyPageView?.calendarButton.addTarget(self, action: #selector(calendarButtonTapped), for: .touchUpInside)
        historyPageView?.toClientKaspi.addTarget(self, action: #selector(toClientKaspiPressed), for: .touchUpInside)
    }
    
    private func setupDelegates(){
        historyPageView?.tableView.delegate = self
        historyPageView?.scrollView.delegate = self
        historyPageView?.tableView.dataSource = self
        historyPageView?.searchTextField.delegate = self
        historyPageView?.calendar.delegate = self
        
        let dateSelection = UICalendarSelectionMultiDate(delegate: self)
        historyPageView?.calendar.selectionBehavior = dateSelection
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
            historyPageView?.tableView.reloadData()
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
        
        historyPageView?.calendarButton.updateTitle(to: "\(startDateString) - \(endDateString)")
    }
    private func filterTransactionsByDateRange(startDate: Date, endDate: Date) {
        isDateFiltering = true
        
        let filteredByDate = transactions.filter { transaction in
            guard let transactionDate = transaction.date else { return false }
            let calendar = Calendar.current
            let adjustedEndDate = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: endDate) ?? endDate
            return transactionDate >= startDate && transactionDate <= adjustedEndDate
        }
        
        if let searchText = historyPageView?.searchTextField.text, !searchText.isEmpty {
            filteredTransactions = filteredByDate.filter { transaction in
                transaction.name?.lowercased().contains(searchText.lowercased()) ?? false
            }
        } else {
            filteredTransactions = filteredByDate
        }
        
        historyPageView?.tableView.reloadData()
    }
    @objc private func calendarButtonTapped(_ sender: CustomButton) {
        setupCalendarDelegates(historyPageView?.calendar ?? UICalendarView())
        historyPageView?.setupCalendar()
        self.present(historyPageView?.calendarViewController ?? UIViewController(), animated: true, completion: nil)
    }
    
    //MARK: SegmentControler
    @objc private func segmentControler(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            historyPageView?.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        case 1:
            historyPageView?.scrollView.setContentOffset(CGPoint(x: 393, y: 0), animated: true)
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
        guard let searchText = historyPageView?.searchTextField.text, !searchText.isEmpty else {
            filteredTransactions = transactions
            historyPageView?.tableView.reloadData()
            return
        }
        filteredTransactions = transactions.filter { transaction in
            return transaction.name?.lowercased().contains(searchText.lowercased()) ?? false
        }
        historyPageView?.tableView.reloadData()
    }
}

extension HistoryViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y == 0 {
            let width = scrollView.bounds.size.width
            let page = Int((scrollView.contentOffset.x + (0.5 * width)) / width)
            historyPageView?.segmentController.selectedSegmentIndex = page
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
            historyPageView?.calendarViewController.dismiss(animated: true)
        }
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        firstDate = nil
    }
}
