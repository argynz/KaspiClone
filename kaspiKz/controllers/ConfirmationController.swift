import UIKit
import CoreData

class ConfirmationController: UIViewController{
    @IBOutlet weak var resiverNameLabel: UILabel!
    @IBOutlet weak var confirmationButton: UIButton!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var bottomViewCT: NSLayoutConstraint!
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var moneyLabel1: UILabel!
    var name = ""
    var money = ""
    var message: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resiverNameLabel.text = name
        confirmationButton.setTitle("Подтвердить и перевести " + money, for: .normal)
        moneyLabel.text = money
        moneyLabel1.text = money
        if message != nil{
            messageLabel.text = message
        }else{
            bottomViewCT.constant = 0
            messageView.isHidden = true
        }
    }
    @IBAction func confirmationButtonPressed(_ sender: UIButton) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedObjectContext = appDelegate.persistentContainer.viewContext

            // Create a new TransactionEntity object
            let transaction = Transactions(context: managedObjectContext)
            transaction.name = name
            transaction.money = money
            transaction.message = message
            transaction.date = Date()

            // Attempt to save the context
            do {
                try managedObjectContext.save()
                // Perform the segue
                performSegue(withIdentifier: "TransactionSuccess", sender: self)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                // Handle the error, such as showing an alert to the user
            }
        
        
    }
}
