//
//  ViewController.swift
//  Link
//
//  Created by Phil Milot on 8/19/16.
//  Copyright © 2016 Phil Milot. All rights reserved.
//

import UIKit
import Contacts
import MessageUI
import CoreData

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class NewContactViewController: UIViewController {

    var contactStore = CNContactStore()

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var lastNameToFirstNameConstraint: NSLayoutConstraint!
    @IBOutlet weak var phoneNumberToLastNameConstraint: NSLayoutConstraint!
    @IBOutlet weak var doneButtonToPhoneNumberConstraint: NSLayoutConstraint!
    
    
    var openTextFieldAnimation = true
    
    @IBOutlet weak var doneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestForAccess { (accessGranted) in
            //playa
        }
        
        if self.revealViewController() != nil {
            navigationItem.rightBarButtonItem?.target = self.revealViewController()
            navigationItem.rightBarButtonItem?.action = "rightRevealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().rightViewRevealOverdraw = 0
        }
        
        navigationItem.leftBarButtonItem?.target = self
        navigationItem.leftBarButtonItem?.action = #selector(showWelcomeViewController)
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        addDoneButtonOnNumpad(phoneNumberTextField)
        
        doneButton.layer.cornerRadius = 38
        doneButton.layer.borderWidth = 4
        doneButton.layer.borderColor = doneButton.titleLabel?.textColor.cgColor
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewContactViewController.dismissKeyboard))
        backgroundView.addGestureRecognizer(tap)
        
        
        firstNameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        firstNameTextField.attributedPlaceholder = NSAttributedString(string:"first name", attributes:[NSForegroundColorAttributeName: UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.00)])
        firstNameTextField.textColor = UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.00)
        firstNameTextField.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.00)
        firstNameTextField.autocapitalizationType = .words
        firstNameTextField.layer.cornerRadius = 8
        firstNameTextField.layer.borderColor = UIColor.white.cgColor
        firstNameTextField.layer.borderWidth = 1
        firstNameTextField.tintColor = UIColor.white
        
        lastNameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        lastNameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        lastNameTextField.attributedPlaceholder = NSAttributedString(string:"last name", attributes:[NSForegroundColorAttributeName: UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.00)])
        lastNameTextField.textColor = UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.00)
        lastNameTextField.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.00)
        lastNameTextField.autocapitalizationType = .words
        lastNameTextField.layer.cornerRadius = 8
        lastNameTextField.layer.borderColor = UIColor.white.cgColor
        lastNameTextField.layer.borderWidth = 1
        lastNameTextField.tintColor = UIColor.white
        
        phoneNumberTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        phoneNumberTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        phoneNumberTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        phoneNumberTextField.attributedPlaceholder = NSAttributedString(string:"phone number", attributes:[NSForegroundColorAttributeName: UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.00)])
        phoneNumberTextField.textColor = UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.00)
        phoneNumberTextField.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.00)
        phoneNumberTextField.autocapitalizationType = .words
        phoneNumberTextField.layer.cornerRadius = 8
        phoneNumberTextField.layer.borderColor = UIColor.white.cgColor
        phoneNumberTextField.layer.borderWidth = 1
        phoneNumberTextField.tintColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navBarSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.getUserNameForSMS() == nil {
            showWelcomeViewController()
        }
    }
    
    func showWelcomeViewController() {
        let view = storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
        present(view, animated: true, completion: nil)
    }
    
    func navBarSetup() {
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black]
        navigationItem.title = "Link"
        navigationController?.navigationBar.isTranslucent = true
        
        self.title = "Link"
        let tlabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        tlabel.text=self.navigationItem.title;
        tlabel.textColor = UIColor.black
        tlabel.font = UIFont(name: "Lighthouse Personal Use", size: 44)
        tlabel.backgroundColor = UIColor.clear
        tlabel.adjustsFontSizeToFitWidth = true
        tlabel.textAlignment = .center
        self.navigationItem.titleView = tlabel;
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func doneButtonTapped(_ sender: AnyObject) {
        if phoneNumberTextField.text?.characters.count == 10 && firstNameTextField.text?.characters.count > 0 {
            
            createContact()
            
            let messageVC = MFMessageComposeViewController()
            
            let name = UserDefaults.getUserNameForSMS()!
            messageVC.body = "Hey \(firstNameTextField.text!), \(name) added you via Link!";
            messageVC.recipients = ["\(phoneNumberTextField.text!)"]
            messageVC.messageComposeDelegate = self;
            
            self.present(messageVC, animated: false, completion: nil)
        }
    }
    
    func requestForAccess(_ completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        
        switch authorizationStatus {
        case .authorized:
            completionHandler(true)
            
        case .denied, .notDetermined:
            self.contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (access, accessError) -> Void in
                if access {
                    completionHandler(access)
                }
                else {
                    if authorizationStatus == CNAuthorizationStatus.denied {
                        
                    }
                }
            })
            
        default:
            completionHandler(false)
        }
    }
    
    func createContact() {
        let newContact = CNMutableContact()
        
        newContact.givenName = firstNameTextField.text!
        newContact.familyName = lastNameTextField.text!
        
        newContact.phoneNumbers = [CNLabeledValue(
            label:CNLabelPhoneNumberMobile,
            value:CNPhoneNumber(stringValue: phoneNumberTextField.text!))]
        
        do {
            let saveRequest = CNSaveRequest()
            saveRequest.add(newContact, toContainerWithIdentifier: nil)
            try contactStore.execute(saveRequest)
        } catch {
          
        }
        saveContact(withName: firstNameTextField.text! + " " + lastNameTextField.text!, number: phoneNumberTextField.text!)
    }
}



//MARK:- Core Data Save
extension NewContactViewController {
    func saveContact(withName name: String, number: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let manangedObject = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: manangedObject)
        let contact = NSManagedObject(entity: entity!, insertInto: manangedObject)
        contact.setValue(name, forKey: "name")
        contact.setValue(number, forKey: "phoneNumber")
        contact.setValue(Date(), forKey: "date")
        
        do {
            try manangedObject.save()
        } catch let error as NSError {
            print("could not save due to \(error)")
        }
    }
}



//MARK:- Animations and keyboard methods
extension NewContactViewController {
    func animateFieldsShut() {
        UIView.animate(withDuration: 0.2, animations: {
            self.lastNameToFirstNameConstraint.constant = 10
            self.phoneNumberToLastNameConstraint.constant = 10
            self.doneButtonToPhoneNumberConstraint.constant = 20
            self.view.layoutIfNeeded()
        })
    }
    
    func animateFieldsOpen() {
        UIView.animate(withDuration: 0.2, animations: {
            self.lastNameToFirstNameConstraint.constant = 20
            self.phoneNumberToLastNameConstraint.constant = 40
            self.doneButtonToPhoneNumberConstraint.constant = 70
            self.view.layoutIfNeeded()
        })
    }
    
    
    func dismissKeyboard() {
        animateFieldsOpen()
        openTextFieldAnimation = true
        view.endEditing(true)
    }
    
    func addDoneButtonOnNumpad(_ textField: UITextField) {
        
        let keypadToolbar: UIToolbar = UIToolbar()
        
        // add a done button to the numberpad
        keypadToolbar.items=[
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: textField, action: #selector(UITextField.resignFirstResponder))
            
        ]
        keypadToolbar.sizeToFit()
        // add a toolbar with a done button above the number pad
        textField.inputAccessoryView = keypadToolbar
    }
}



extension NewContactViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameTextField:
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            phoneNumberTextField.becomeFirstResponder()
        case phoneNumberTextField:
            textField.resignFirstResponder()
            animateFieldsOpen()
            openTextFieldAnimation = true
        default:
            break
        }
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        openTextFieldAnimation = false
        animateFieldsShut()
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !openTextFieldAnimation {
            
        }
    }
}



extension NewContactViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        openTextFieldAnimation = true
        switch (result) {
        case MessageComposeResult.cancelled:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
            animateFieldsOpen()
        case MessageComposeResult.failed:
            print("Message failed")
            self.dismiss(animated: true, completion: nil)
            animateFieldsOpen()
        case MessageComposeResult.sent:
            print("Message was sent")
            self.dismiss(animated: true, completion: nil)
            animateFieldsOpen()
        }
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        phoneNumberTextField.text = ""
    }
}




