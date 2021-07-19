//
//  ContactTableViewCell.swift
//  ContactList
//
//  Created by Aaron Cleveland on 7/19/21.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    static var identifier: String = "ContactTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
