import Foundation
import FirebaseAuth

class AuthUser {
    static func createUser(email:String, pass:String, completion: @escaping (User?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: pass) {(user, error) in
            if error != nil {
                print(error.debugDescription)
                completion(nil)
                return
            }
            
            if let createdUser = user {
                completion(createdUser)
            } else {
                completion(nil)
                print("Nao foi possivel criar usuario")
            }
        }
    }
    
    static func signIn(email:String, pass:String, completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error) in
            if (user != nil) {
                if let email = user?.email {
                    completion(email)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        })
    }
    
    static func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            return false
        }
    }
    
    static func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
}
