import UIKit
import SystemConfiguration.CaptiveNetwork

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var splashSpinnerContainer: UIImageView!
    @IBOutlet weak var status: UILabel!
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    
    override func viewDidAppear(animated: Bool) {
        checkIfConnectedToWifi()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "checkIfConnectedToWifi", name: Constants.updateLoginStatusKey, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.backgroundColor = UIColor.clearColor()
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        loginButton.titleEdgeInsets = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
        loginButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Disabled)
        loginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        loginButton.setTitleColor(UIColorFromRGB(0x0977BA), forState: UIControlState.Highlighted)
        loginButton.addTarget(self, action: Selector("holdRelease:"), forControlEvents: UIControlEvents.TouchUpInside);
        loginButton.addTarget(self, action: Selector("holdDown:"), forControlEvents: UIControlEvents.TouchDown)
        
        loginButton.layer.borderColor = UIColor.grayColor().CGColor
        loginButton.enabled = false
        
        status.textColor = UIColor.whiteColor()
        status.font = status.font.fontWithSize(20)
        
        status.text = "Validating Wifi ..."
    }
    
    @IBAction func login(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: Constants.loginUrl + UIDevice.currentDevice().identifierForVendor!.UUIDString)!)
    }
    
    func holdDown(sender:UIButton) {
        if ( loginButton.enabled ) {
            loginButton.backgroundColor = UIColor.whiteColor()
        }
    }
    
    func holdRelease(sender:UIButton) {
        if ( loginButton.enabled ) {
            loginButton.backgroundColor = UIColorFromRGB(0x0977BA)
        }
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func checkIfConnectedToWifi() {
        
        loginButton.layer.borderColor = UIColor.grayColor().CGColor
        loginButton.enabled = false
        
        status.textColor = UIColor.whiteColor()
        status.font = status.font.fontWithSize(20)
        
        status.text = "Validating Wifi ..."
        
        spinner.frame = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
        spinner.startAnimating()
        splashSpinnerContainer.addSubview(spinner)
        
        if (currentSSID() == Constants.SSID) {
            status.text = "Click the button below to login."
            
            spinner.alpha = 0.0
            
            loginButton.layer.borderColor = UIColor.whiteColor().CGColor
            loginButton.enabled = true
        } else {
            spinner.alpha = 0.0
            
            status.text = "Please connect to Metro Free Wifi."
        }
    }
    
    func currentSSID() ->String {
        var currentSSID: String = ""
        let interfaces: CFArray! = CNCopySupportedInterfaces()
        if interfaces != nil {
            for i in 0..<CFArrayGetCount(interfaces) {
                let interfaceName: UnsafePointer<Void> = CFArrayGetValueAtIndex(interfaces, i)
                let rec = unsafeBitCast(interfaceName, AnyObject.self)
                let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)")
                if unsafeInterfaceData != nil {
                    let interfaceData = unsafeInterfaceData! as Dictionary!
                    currentSSID = interfaceData["SSID"] as! String
                }
            }
        }
        
        return currentSSID
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
