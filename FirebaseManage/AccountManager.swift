import Foundation
import FirebaseAuth
import Firebase

struct DBAccountModel {
    let uid: String
    let login: String
    let email: String
}
class AccountManager {
    public static let shared = AccountManager(accountModel: <#T##AccountModel#>)
    private var userIdentifier: String?
    
    private let login: String
    private let email: String
    private let password: String
//    private let accountModel: AccountModel
    
    private let referenceOnUsers = Database.database().reference().child("users")
//    private let referenceOnFriends = Database.database().reference().child("users").child("friends")
    
    public init?(accountModel: AccountModel) {
        guard let login = accountModel.login,
              let email = accountModel.email, !email.isEmpty,
              let password = accountModel.password, !password.isEmpty else { return nil }
        
        self.login = login
        self.email = email
        self.password = password
//        self.accountModel = accountModel
    }
    
    public func createAccount() {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [self] (result ,error) in
            guard let result, error == nil else { return }
            let identifier = result.user.uid
            self.userIdentifier = identifier
            referenceOnUsers.child(identifier).setValue(["login": login,
                                                         "email": email
                                                        ])
        }
    }
    
    public func authorization(completionHandler: @escaping () -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else { return }
            completionHandler()
        }
    }
    
    public func addFriend(withLogin login: String?) {
        guard let dbAccount = getAccount(withLogin: login) else { return }
        setFriend(withDBModel: dbAccount)
    }
    
    private func getAccount(withLogin login: String?) -> DBAccountModel? {
        var dbAccountModel: DBAccountModel?
        guard let login else { return nil }
        referenceOnUsers.observe(.value, with: { snapshot in
            guard let users = snapshot.value as? [String: [String: String]] else { return }
            // [uid: [login: email]] or [login: [email: login]]
            
            for currentUserUID in users.keys {
                guard let userFields = users[currentUserUID],
                        let currentUserLogin = userFields["login"], currentUserLogin == login,
                        let currentUserEmail = userFields["email"] else { return }
                
                dbAccountModel = DBAccountModel(uid: currentUserUID,
                                                login: currentUserLogin,
                                                email: currentUserEmail)
            }
        })
        return dbAccountModel
    }
    private func setFriend(withDBModel dbModel: DBAccountModel) {
        guard let userIdentifier else { return }
        
        referenceOnUsers.child(userIdentifier).child("friends").setValue([
            dbModel.uid: ["login": dbModel.login, "email": dbModel.email]
        ])
        
        referenceOnUsers.child(dbModel.uid).child("friends").setValue([
            self.userIdentifier: ["login": self.login, "email": self.email]
        ])
    }
}
