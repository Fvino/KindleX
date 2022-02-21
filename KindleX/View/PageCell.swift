//
//  PageCell.swift
//  KindleX
//
//  Created by Valeriy Fomin on 15/2/22.
//

import UIKit

class PageCell: UICollectionViewCell {

    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Some text for our label Some text for our label Some text for our label Some text for our label Some text for our label Some text for our label Some text for our label Some text for our label Some text for our label Some text for our label Some text for our label Some text for our label"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(textLabel)

        textLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        textLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
