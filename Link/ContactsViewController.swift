//
//  ContactsViewController.swift
//  Link
//
//  Created by Phil Milot on 8/29/16.
//  Copyright © 2016 Phil Milot. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ContactsViewController : UIViewController {
    
    @IBOutlet weak var contactsTableView: UITableView!
    var addedContacts = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
    }
    
    
}



extension ContactsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
//        cell.label = addedContacts.valueForKey("name") as? String
    }
}



extension ContactsViewController: UITableViewDelegate {
    
}
