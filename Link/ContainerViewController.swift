//
//  ContainerViewController.swift
//  Link
//
//  Created by Phil Milot on 8/29/16.
//  Copyright © 2016 Phil Milot. All rights reserved.
//

import Foundation
import UIKit

class ContainerViewController : UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.35, green:0.53, blue:0.78, alpha:1.00)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard {return UIStoryboard(name: "Main", bundle: Bundle.main) }
        
    class func contactsViewController() -> ContactsViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "ContactsViewController") as? ContactsViewController
    }
}

struct Colors {
    
}
