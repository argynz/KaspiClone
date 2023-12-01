import UIKit
import CoreData

class SegmentViewControler: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControler: UISegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var transactions: [Transactions] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        tableView.dataSource = self
        fetchTransactions()
    }
    
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
}
extension SegmentViewControler: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath)
        
        let transaction = transactions[indexPath.row]
        cell.textLabel?.text = transaction.name! + " перевел " + transaction.money! 
        
        return cell
    }
    
    
}

extension SegmentViewControler: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(scrollView.contentOffset.x / pageWidth)
                
        segmentControler.selectedSegmentIndex = page
    }
}
