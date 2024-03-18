//
//  FriendsViewController.swift
//  MapProject
//
//  Created by Lushnikov Anatoliy on 28.09.2023.
//

import UIKit
import FirebaseDatabase
class FriendsViewController: UIViewController {
    let searchFriendController = UISearchController(searchResultsController: nil)
    let tableViewFriends = FriendTableView()
    
    override func viewDidLoad() {
//        let reference = Database.database().reference().child("friends")
//        let identifier = reference.
//        reference.child(userIdentifier).updateChildValues(["login" : "self.login",
//                                                           "email" : "self.email",
//                                                          ])
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Список друзей"
        setAddFriendButton()
        setLayoutConstraints()
        setupForSearchController(searchFriendController, withPlaceholder: "ffff")
    }
    @objc private func addFriendAction() {
        print("Работает")
        AccountManager(accountModel: <#AccountModel#>)!.addFriend(withLogin: "111111")
    }
    
    private func setAddFriendButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addFriendAction))
    }
    private func setupForSearchController(_ searchController: UISearchController, withPlaceholder placeholder: String?) {
        searchController.searchBar.placeholder = placeholder
        self.navigationItem.searchController = searchController
    }
    
    private func setLayoutConstraints() {
        view.addSubview(tableViewFriends)
        tableViewFriends.translatesAutoresizingMaskIntoConstraints = false 
        NSLayoutConstraint.activate([
            tableViewFriends.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViewFriends.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewFriends.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewFriends.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
