//
//  FriendTableViewCell.swift
//  MapProject
//
//  Created by Анатолий Лушников on 14.03.2024.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    private let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupForLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func setText(text: String?) {
        label.text = text
    }
    private func setupForLabel() {
        self.addSubview(label)
        label.center = self.center
        label.textColor = .black
    }
}
