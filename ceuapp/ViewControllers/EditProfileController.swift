import Foundation
import UIKit

class EditProfile: UIViewController{
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated:false);
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelChangesButtonClick(sender:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveChangesButtonClick(sender:)))
        
        fillProfile()
    }
    
    func showAlert(title:String, message:String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(controller, animated: true, completion: nil)
    }
    
    func cancelChangesButtonClick(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveChangesButtonClick(sender: UIBarButtonItem) {
        let userEmail: String = self.emailTextField.text!
        let userName: String = self.nameTextField.text!
        let userTitle: String = self.titleTextField.text!
        let userCompany: String = self.companyTextField.text!
        let userDescription: String = self.descriptionTextField.text!
        
        // TODO: colocar tipo de conta correto
        let appUser = AppUser(name: userName, title: userTitle, decription: userDescription, email: userEmail, company: userCompany, type: "4")
        DAO.saveUserInfo(appUser: appUser)
    }
    
    func fillProfile(){
        DAO.getUserInfo { (appUser) in
            self.emailTextField.text = (appUser?.userEmail)!
            self.nameTextField.text = (appUser?.userName)!
            self.titleTextField.text = (appUser?.userTitle)!
            self.companyTextField.text = (appUser?.userCompany)!
            self.descriptionTextField.text = (appUser?.userDescription)!
        }
    }
}
