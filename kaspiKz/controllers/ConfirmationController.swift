import UIKit
import CoreData

class ConfirmationController: UIViewController{
    @IBOutlet weak var resiverNameLabel: UILabel!
    @IBOutlet weak var confirmationButton: UIButton!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var bottomViewCT: NSLayoutConstraint!
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    var name = String()
    var money = String()
    var message: String?
    
    lazy var storyB = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIU()
    }
    func setupIU(){
        resiverNameLabel.text = name
        confirmationButton.setTitle("Подтвердить и перевести " + money, for: .normal)
        moneyLabel.text = money
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

            let transaction = Transactions(context: managedObjectContext)
            transaction.name = name
            transaction.money = money
            transaction.message = message
            transaction.date = Date()
        
            do {
                try managedObjectContext.save()
                // Bottom Sheet
                if let bottomSheet = storyB.instantiateViewController(withIdentifier: "TransferSuccessViewController") as? TransferSuccessViewController{
                    if let sheet = bottomSheet.sheetPresentationController{
                        sheet.detents = [.large(), .medium()]
                        sheet.prefersGrabberVisible = true
                    }
                    bottomSheet.name = name
                    bottomSheet.money = money
                    self.present(bottomSheet, animated: true)
                }
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        
    }
}
