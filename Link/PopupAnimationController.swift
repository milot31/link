//
//  PopupAnimationController.swift
//  Link
//
//  Created by Phil Milot on 2/20/17.
//  Copyright © 2017 Phil Milot. All rights reserved.
//

import Foundation

let kInitialScale:CGFloat = 1.3

class PopupAnimationController : NSObject, UIViewControllerAnimatedTransitioning {
    
    var reverse: Bool = false
    let animationDuration = 0.25
    var calculateHeight = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        let fromView = fromVC!.view
        let toView = toVC!.view
        let containerView = transitionContext.containerView
        
        // Presenting
        if (!reverse) {
            fromView?.isUserInteractionEnabled = false
            
            let center = fromView?.center
            
            if calculateHeight {
                //create temp label for height caculations
                let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 285 - 44, height: CGFloat.greatestFiniteMagnitude))
                label.numberOfLines = 0
                label.lineBreakMode = NSLineBreakMode.byWordWrapping
                label.font = UIFont(name: "Montserrat-UltraLight", size: 15)
                label.text = (toVC as! PopupViewController).descText
                
                label.sizeToFit()
                let height = label.frame.height
                
                toView?.frame = CGRect(x: (center?.x)! - (285 * 0.5), y: (center?.y)! - ((height + 60 + 44 + 44) * 0.5) , width: 285, height: height + 60 + 44 + 44)
            }
            else {
                toView?.frame = CGRect(x: (center?.x)! - (285 * 0.5), y: (center?.y)! - ((500) * 0.5) , width: 285, height: 500)
            }
            
            // Set initial scale to zero
            toView?.transform = CGAffineTransform(scaleX: kInitialScale, y: kInitialScale)
            toView?.alpha = 0
            
            toView?.layer.shadowColor = UIColor.black.cgColor
            toView?.layer.shadowOffset = CGSize(width: 0, height: 10)
            toView?.layer.shadowOpacity = 0.4
            toView?.layer.shadowRadius = 5
            
            containerView.addSubview(toView!)
            
            UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
                toView?.transform = CGAffineTransform.identity
                toView?.alpha = 1
                fromView?.alpha = 0.8
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
        else {
            // Scale down to 0
            UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
                fromView?.transform = CGAffineTransform(scaleX: kInitialScale, y: kInitialScale)
                fromView?.alpha = 0
                toView?.alpha = 1
            }, completion:  { finished in
                toView?.isUserInteractionEnabled = true
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
}



