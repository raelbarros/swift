import Foundation
import Firebase
import UIKit

class SignInView: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated:false);
    }
    
    func showAlert(title:String, message:String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if let email = emailTextField.text, let pass = passwordTextField.text{
            AuthUser.signIn(email: email, pass: pass, completion: { (String) in
                if String != nil{
                    self.navigationController?.popViewController(animated: false)
                } else {
                    self.showAlert(title: "Erro", message: "Login Fail")
                }
            })
        }
    }
    
    @IBAction func createUserButton(_ sender: Any) {
        if let email = emailTextField.text, let pass = passwordTextField.text {
            AuthUser.createUser(email: email, pass: pass, completion: { (user) in
                if user != nil {
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "screenEditProfile") as! EditProfile
                    self.navigationController?.pushViewController(controller, animated: true)
                } else {
                    self.showAlert(title: "Erro", message: "Nao foi possivel possivel criar usuario.")
                }
            })
        }
    }
    
}
