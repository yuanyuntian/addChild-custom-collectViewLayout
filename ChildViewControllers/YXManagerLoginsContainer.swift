//
//  YXManagerLoginsContainer.swift
//  ChildViewControllers
//
//  Created by yf on 2019/12/5.
//  Copyright © 2019 yf. All rights reserved.
//

import UIKit

class YXManagerLoginsContainer: UIViewController {

    private var state:type?
    
    
    lazy var VC_A:ViewControllerA = {
        let v = ViewControllerA(superVC: self)
        return v
    }()
    
    lazy var VC_B:ViewControllerB = {
        let v = ViewControllerB(superVC: self)
        return v
    }()

    lazy var VC_C:ViewControllerC = {
        let v = ViewControllerC(superVC: self)
        return v
    }()
    
    
    
    ///当前控制器
    private var currentVC:UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.addChild(VC_A)
        self.addChild(VC_B)
        self.addChild(VC_C)
        


        self.view.addSubview(VC_A.view)
        self.currentVC = VC_A
        // Do any additional setup after loading the view.
    }
    
    
    
    func transition (to newState: type) {
        
        let vc = viewController(for: newState)

        var options:UIView.AnimationOptions?
        var animations: (() -> Void)?

        switch newState {
        case .A(let way):
            if way == .left {
                vc.view.benX = -vc.view.benWidth
                options = .curveEaseOut
                animations = {
                    vc.view.benX = 0
                }
            }else{
                options = .curveEaseOut
                vc.view.benX = vc.view.benWidth
                animations = {
                    vc.view.benX = 0
                }
            }
        case .B(let way):
            if way == .left {
                vc.view.benX = -vc.view.benWidth
                options = .curveEaseOut
                animations = {
                    vc.view.benX = 0
                }
            }else{
                options = .curveEaseOut
                vc.view.benX = vc.view.benWidth
                animations = {
                    vc.view.benX = 0
                }
            }
        case .C(let way):
            if way == .left {
                vc.view.benX = -vc.view.benWidth
                options = .transitionCrossDissolve
                animations = {
                    vc.view.benX = 0
                }
            }else{
                options = .curveEaseOut
                vc.view.benX = vc.view.benWidth
                animations = {
                    vc.view.benX = 0
                }
            }
        }
        
        self.transition(from: self.currentVC!, to: vc, duration: 0.2, options: options ?? [], animations:animations, completion: { (finished) in
            self.currentVC = vc
         })
//        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
//            vc.view.benX += 4
//        }, completion:  { (finished) in
//            if finished {
//                vc.view.benX = 0
//            }
//        })
        
        state = newState
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    deinit {
        print("deinit")
    }

}

extension YXManagerLoginsContainer {
    
    enum type {
        
        ///手机验证码登录
        case A(animation:AnimationWay)
        
        ///账号密码登录
        case B(animation:AnimationWay)
        
        ///查找密码
        case C(animation:AnimationWay)
        
    }
    
    
    /// 进入方向
    enum AnimationWay {
        case left
        case right
    }
    
}


private extension YXManagerLoginsContainer {
    func viewController(for state: type) -> UIViewController {
        switch state {
        case .A:
            return self.VC_A
        case .B:
            return self.VC_B
        case .C:
            return self.VC_C
        }
    }
}
