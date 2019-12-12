//
//  UIViewController+Extension.swift
//  ChildViewControllers
//
//  Created by yf on 2019/12/5.
//  Copyright © 2019 yf. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func add (_ child:UIViewController){
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
