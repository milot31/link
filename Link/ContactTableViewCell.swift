//
//  ContactTableViewCell.swift
//  Link
//
//  Created by Phil Milot on 12/24/16.
//  Copyright © 2016 Phil Milot. All rights reserved.
//

import Foundation

class ContactTableViewCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        locationLabel.text = ""
        dateLabel.text = ""
    }
}
