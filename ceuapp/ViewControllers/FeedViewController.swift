import UIKit

import FirebaseAuth

class FeedView : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        if(Auth.auth().currentUser == nil) {
            openSignInScreen()
        }
    }
    
    @IBAction func SignOutButtonClick(_ sender: Any) {
        if AuthUser.signOut() {
            let defaults = UserDefaults.standard
            
            defaults.removeObject(forKey: DefaultKeys.dbCodeeEmail)
            defaults.removeObject(forKey: DefaultKeys.dbCodeName)
            defaults.removeObject(forKey: DefaultKeys.dbCodeTitle)
            defaults.removeObject(forKey: DefaultKeys.dbCodeDescription)
            defaults.removeObject(forKey: DefaultKeys.dbCodeCompany)
            defaults.removeObject(forKey: DefaultKeys.dbCodeType)
            
            openSignInScreen()
        }
    }
    
    func openSignInScreen() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "screenSignIn") as! SignInView
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    @IBAction func openProfileScreen(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "screenProfile") as! ProfileView
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
