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
        
    }
    
    
    
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        //userdefaults
        dismiss(animated: true, completion: nil)
    }
}




extension WelcomeViewController: UINavigationControllerDelegate, UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animator = PopupAnimationController()
        animator.calculateHeight = false
        animator.reverse = false
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animator = PopupAnimationController()
        animator.calculateHeight = false
        animator.reverse = true
        return animator
    }
}
