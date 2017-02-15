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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manangedObject = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        
        do {
            let results = try manangedObject.fetch(fetchRequest)
            addedContacts = results as! [NSManagedObject]
            contactsTableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
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
        let cont = addedContacts[indexPath.row] as! Contact
        
        cell.setUpCell(cont)
        
        return cell
    }
}



extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73
    }
}
