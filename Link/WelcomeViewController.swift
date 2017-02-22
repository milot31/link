//
//  WelcomeViewController.swift
//  Link
//
//  Created by Phil Milot on 2/20/17.
//  Copyright © 2017 Phil Milot. All rights reserved.
//

import Foundation

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    convenience init() {
        self.init(nibName: "WelcomeViewController", bundle: nil)
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        nameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        nameTextField.attributedPlaceholder = NSAttributedString(string:"your name", attributes:[NSForegroundColorAttributeName: UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.00)])
        nameTextField.textColor = UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.00)
        nameTextField.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.00)
        nameTextField.autocapitalizationType = .words
        nameTextField.layer.cornerRadius = 8
        nameTextField.layer.borderColor = UIColor.white.cgColor
        nameTextField.layer.borderWidth = 1
        nameTextField.tintColor = UIColor.white
        doneButton.layer.cornerRadius = 8
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        if let txt = nameTextField.text {
            if txt.characters.count > 0 {
                UserDefaults.setUserNameForSMS(txt)
                dismiss(animated: true, completion: nil)
            }
        }
    }
}


extension WelcomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}




extension WelcomeViewController: UINavigationControllerDelegate, UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animator = PopupAnimationController()
        animator.reverse = false
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animator = PopupAnimationController()
        animator.reverse = true
        return animator
    }
}
