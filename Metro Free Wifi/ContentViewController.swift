import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var titleLabel: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    var pageIndex: Int!
    var imageFile: String!
    var titleText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = UIImage(named: self.imageFile)
        
        self.titleLabel.text = self.titleText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
