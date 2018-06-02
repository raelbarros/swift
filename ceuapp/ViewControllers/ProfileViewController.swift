import Foundation
import UIKit

class ProfileView: UIViewController{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var profilePictureView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editProfileButtonClick(sender:)))
        fillProfile()
    }
    
    func editProfileButtonClick(sender:UIBarButtonItem){
        let controller = storyboard?.instantiateViewController(withIdentifier: "screenEditProfile") as! EditProfile
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func fillProfile() {
        let uid = AuthUser.getCurrentUser()?.uid
        
        DAO.getUserInfo { (appUser) in
            if let userName = appUser?.userName {
                self.nameLabel.text = userName
                self.descriptionLabel.text = appUser?.userDescription
                
                do {
                    let fileName = uid! + ".jpg"
                    let fileManager = FileManager.default
                    let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
                    let fileURL = documentDirectory.appendingPathComponent(fileName)
                    
                    self.profilePictureView.contentMode = .scaleAspectFit
                    self.profilePictureView.image = UIImage(contentsOfFile: fileURL.path)
                }
                catch {
                    print(error)
                }
                
                if let filePath = Bundle.main.path(forResource: uid, ofType: "jpg"), let image = UIImage(contentsOfFile: filePath) {
                    self.profilePictureView.contentMode = .scaleAspectFit
                    self.profilePictureView.image = image
                }
                else {
                    print("erro ao carregar imagem local")
                }
            }
            else {
                print("Nao foi possivel carregar os dados do usuario")
            }
        }
    }
}
