import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tadaimaButton: UIButton!
    
    @IBAction func tadaimaTapped(sender: AnyObject) {
        let name = nameTextField.text
        println("Tapped as \(name)")
        TadaimaManager.sharedInstance.ただいま(name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

