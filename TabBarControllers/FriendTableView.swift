//
//  FriendTableView.swift
//  MapProject
//
//  Created by Анатолий Лушников on 14.03.2024.
//

import UIKit

class FriendTableView: UITableView {
    private let testFriends = ["first", "second"]
    private let identifier = "Cell"
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupForTableView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupForTableView() {
        self.delegate = self
        self.dataSource = self
        self.register(FriendTableViewCell.self, forCellReuseIdentifier: identifier)
    }
}

extension FriendTableView: UITableViewDelegate {
    
}

extension FriendTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? FriendTableViewCell else { return UITableViewCell() }
        cell.setText(text: testFriends[indexPath.row])
        return cell
    }
    
    
}
