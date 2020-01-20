//
//  HomeTableViewCell.swift
//  ContactsApp
//
//  Created by Mohammed Sadiq on 20/01/20.
//  Copyright © 2020 Mohammed Sadiq. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
