import FirebaseDatabase
import FirebaseStorage
import Foundation

class DAO {
    static let databaseRef = Database.database().reference()
    
    static func getUserInfo(completion: @escaping (AppUser?) -> Void) {
        let defaults = UserDefaults.standard
        
        if let userName = defaults.string(forKey: DefaultKeys.dbCodeName) {
            let userTitle: String = defaults.string(forKey: DefaultKeys.dbCodeTitle)!
            let userCompany: String = defaults.string(forKey: DefaultKeys.dbCodeCompany)!
            let userDescription: String = defaults.string(forKey: DefaultKeys.dbCodeDescription)!
            let userType: String = defaults.string(forKey: DefaultKeys.dbCodeType)!
            
            let userEmail = AuthUser.getCurrentUser()?.email
        
            let userInfo = AppUser(name: userName, title: userTitle, decription: userDescription, email: userEmail!, company: userCompany, type: userType)
            completion(userInfo)
        }
        else {
            downloadUserInfo(completion: { (appUser) in
                saveUserInfo(appUser: appUser!)
                completion(appUser)
            })
        }
    }
    
    static func saveUserInfo(appUser: AppUser) {
        let defaults = UserDefaults.standard
        
        defaults.set(appUser.userEmail, forKey: DefaultKeys.dbCodeeEmail)
        defaults.set(appUser.userName, forKey: DefaultKeys.dbCodeName)
        defaults.set(appUser.userTitle, forKey: DefaultKeys.dbCodeTitle)
        defaults.set(appUser.userDescription, forKey: DefaultKeys.dbCodeDescription)
        defaults.set(appUser.userCompany, forKey: DefaultKeys.dbCodeCompany)
        defaults.set(appUser.userType, forKey: DefaultKeys.dbCodeType)
        
        uploadUserInfo(appUsers: appUser)
    }
    
    static func downloadUserInfo(completion: @escaping (AppUser?) -> Void) {
        let currentUser = AuthUser.getCurrentUser()
        
        if let uid = currentUser?.uid {
            databaseRef.child(DefaultKeys.dbCodeUsers).child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                let data = snapshot.value as? Dictionary<String, Any>
                
                let email = data?[DefaultKeys.dbCodeeEmail] as? String
                let name = data?[DefaultKeys.dbCodeName] as? String
                let title = data?[DefaultKeys.dbCodeTitle] as? String
                let company = data?[DefaultKeys.dbCodeCompany] as? String
                let descripton = data?[DefaultKeys.dbCodeDescription] as? String
                let type = data?[DefaultKeys.dbCodeType] as? String
                
                let fileManager = FileManager.default
                do {
                    let fileName = uid + ".jpg"
                    let storageRef = Storage.storage().reference().child(DefaultKeys.storageCodeProfilePictures).child(fileName)
                    let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
                    let fileURL = documentDirectory.appendingPathComponent(fileName)
                    
                    storageRef.write(toFile: fileURL)
                }
                catch {
                    print(error)
                }
                
                let appUser = AppUser(name: name!, title: title!, decription: descripton!, email: email!, company: company!, type: type!)
                completion(appUser)
            })
        }
    }
    
    static func uploadUserInfo(appUsers: AppUser){
        var userInfo: Dictionary<String, Any> = [:]
        
        userInfo = [ DefaultKeys.dbCodeName: appUsers.userName,
                     DefaultKeys.dbCodeTitle: appUsers.userTitle,
                     DefaultKeys.dbCodeDescription: appUsers.userDescription,
                     DefaultKeys.dbCodeeEmail: appUsers.userEmail,
                     DefaultKeys.dbCodeCompany: appUsers.userCompany,
                     DefaultKeys.dbCodeType: appUsers.userType ]
        
        databaseRef.child(DefaultKeys.dbCodeUsers).child((AuthUser.getCurrentUser()?.uid)!).setValue(userInfo)
    }
}
