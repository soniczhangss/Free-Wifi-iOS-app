import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var splashTitle: UIImageView!
    @IBOutlet weak var splashWifi1: UIImageView!
    @IBOutlet weak var splashWifi2: UIImageView!
    @IBOutlet weak var splashSpinnerContainer: UIImageView!
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        spinner.frame = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
        spinner.startAnimating()
        splashSpinnerContainer.addSubview(spinner)
        splashWifi1.alpha = 0.0
        splashWifi2.alpha = 0.0
        splashTitle.alpha = 0.0
        splashTitle.transform = CGAffineTransformMakeScale(0.6, 0.6)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(1.0, delay: 0.2, options: [.CurveEaseIn], animations: {
            self.splashTitle.alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(1.0, delay: 0.2, options: [.CurveEaseIn], animations: {
            self.splashTitle.transform = CGAffineTransformIdentity
            }, completion: {
                _ in
                UIView.animateWithDuration(0.2, delay: 0.0, options: [], animations: {
                    self.splashWifi1.alpha = 1.0
                    }, completion: {
                        _ in
                        UIView.animateWithDuration(0.2, delay: 0.0, options: [], animations: {
                            self.splashWifi2.alpha = 1.0
                            }, completion: {
                                _ in
                                self.splashWifi1.alpha = 0.0
                                self.splashWifi2.alpha = 0.0
                                
                                UIView.animateWithDuration(0.2, delay: 0.0, options: [], animations: {
                                    self.splashWifi1.alpha = 1.0
                                    }, completion: {
                                        _ in
                                        UIView.animateWithDuration(0.2, delay: 0.0, options: [], animations: {
                                            self.splashWifi2.alpha = 1.0
                                            }, completion: {
                                                _ in
                                                
                                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                                let vc = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as UIViewController
                                                self.presentViewController(vc, animated: true, completion: nil)
                                                
                                                
                                        })
                                })
                        })
                })
        })
        
    }

}
