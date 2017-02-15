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
    
    func setUpCell(_ contact: Contact) {
        if let _name = contact.name {
            nameLabel.text = _name
        }
        if let _date = contact.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E MMMM d, yyyy '@' h:mm a"
            dateLabel.text = dateFormatter.string(from: _date as Date)
        }
        if var fullNumber = contact.phoneNumber {
            if fullNumber.characters.count == 10 {
                fullNumber.insert("(", at: fullNumber.index(fullNumber.startIndex, offsetBy: 0))
                fullNumber.insert(")", at: fullNumber.index(fullNumber.startIndex, offsetBy: 4))
                fullNumber.insert(" ", at: fullNumber.index(fullNumber.startIndex, offsetBy: 5))
                fullNumber.insert("-", at: fullNumber.index(fullNumber.startIndex, offsetBy: 9))
                locationLabel.text = fullNumber
            } else if fullNumber.characters.count == 7 {
                fullNumber.insert("-", at: fullNumber.index(fullNumber.startIndex, offsetBy: 3))
                locationLabel.text = fullNumber
            } else {
                locationLabel.text = fullNumber
            }
        }
    }
}
