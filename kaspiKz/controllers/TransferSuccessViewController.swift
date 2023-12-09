import UIKit
class TransferSuccessViewController: UIViewController{
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var money: UILabel!
    var n = ""
    var m = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = n
        money.text = m
    }
    @IBAction func confirmationButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
