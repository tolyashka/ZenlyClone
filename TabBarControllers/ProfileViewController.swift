//
//  ChatViewController.swift
//  MapProject
//
//  Created by Lushnikov Anatoliy on 28.09.2023.
//

import UIKit
import FirebaseAuth
//import SnapKit
import FirebaseDatabase
class ProfileViewController: UIViewController {
    private let iconImageView: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage()
        icon.layer.cornerRadius = 25
        icon.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        icon.layer.borderWidth = 0.5
        return icon
    }()
    let labelLogin: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    var user = User1()
    var complitionHandlers: ((User1) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getInfoUser { user in
            self.user = user
        }
        print("user: ", user)
    }
    func getInfoUser(completionHandler: @escaping (User1) -> Void) {
        var user = User1()
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("users/\(userUid)")
        ref.getData { [self] error, data in
            guard error == nil,
                  let data = data?.value as? [String: String] else { return }
            user.email = data["email"]!
            user.login = data["login"]!
            complitionHandlers = completionHandler
        }
    }
//    func getLoginUser(completionHandler: @escaping (String) -> Void) {
//        guard let userUid = Auth.auth().currentUser?.uid else { return }
//        let ref = Database.database().reference().child("users/\(userUid)/login")
//        ref.getData { error, data in
//            guard error == nil,
//                  let login = data?.value as? String else { return }
//            print("bbb", login)
//            completionHandler(login)
//        }
//    }
//    private func setupIconWithLogin(login: String) {
//        setupLayout()
//        
//        let label = UILabel()
//        setupLabel()
//        
//        func setupLabel() {
//            iconImageView.addSubview(label)
//            setLayout()
//            label.text = login.first?.uppercased()
//            print("AAAAAAA === ", label.text, "== ", login)
//            label.textAlignment = .center
//            label.font = UIFont.boldSystemFont(ofSize: 20)
//            label.textColor = .black
//        }
//        func setLayout() {
//            label.snp.makeConstraints { make in
//                make.center.equalTo(iconImageView.snp.center)
//            }
//        }
    }
    
//    private func setupLayout() {
//        view.addSubview(iconImageView)
//        iconImageView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(35)
//            make.leading.equalTo(20)
//            make.height.equalTo(150)
//            make.width.equalTo(150)
//        }
//    }
//}
