//
//  YXTransitionAnimatior.swift
//  ChildViewControllers
//
//  Created by yf on 2019/12/7.
//  Copyright © 2019 yf. All rights reserved.
//

import UIKit

class YXTransitionAnimatior: NSObject {

}


extension YXTransitionAnimatior:UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toVC = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        transitionContext.containerView.addSubview(toVC.view)
        toVC.view.alpha = 1
        

        let duration = self.transitionDuration(using: transitionContext)
//        UIView.animate(withDuration: duration, animations: {
//            toVC.view.alpha = 1
//        }) { (finish) in
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        }
        
        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions.transitionCurlUp, animations: {
            toVC.view.alpha = 1
        }) { (finish) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}


