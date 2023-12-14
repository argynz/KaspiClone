import UIKit
class TransferSuccessViewController: UIViewController{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    var name = String()
    var money = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = name
        moneyLabel.text = money
    }
    @IBAction func confirmationButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
