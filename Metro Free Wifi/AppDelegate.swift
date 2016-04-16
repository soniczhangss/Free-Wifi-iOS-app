import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var splashVC : UIViewController?
    var guidVC : UIViewController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let pageController = UIPageControl.appearance()
        pageController.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageController.currentPageIndicatorTintColor = UIColor.blackColor()
        pageController.backgroundColor = UIColor.whiteColor()
        
        let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        splashVC = sb.instantiateViewControllerWithIdentifier("SplashViewController") as UIViewController
        guidVC = sb.instantiateViewControllerWithIdentifier("ViewController") as UIViewController
        
        if ( isFirstTimeLaunch() ) {
            setLaunchKey()
            self.window!.rootViewController = guidVC
            
        } else {
            self.window!.rootViewController = splashVC
        }
        
        return true
    }
    
    func setLaunchKey() {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "MFWFirstTimeLaunch")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func isFirstTimeLaunch() -> Bool {
        var isFirstTimeLaunch = false;
        if ( !NSUserDefaults.standardUserDefaults().boolForKey("MFWFirstTimeLaunch") ) {
            isFirstTimeLaunch = true;
        }
        
        return isFirstTimeLaunch
    }
    func applicationDidBecomeActive(application: UIApplication) {
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.updateLoginStatusKey, object: self)
    }


}

