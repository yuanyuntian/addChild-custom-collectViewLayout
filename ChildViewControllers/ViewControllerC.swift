//
//  ViewControllerC.swift
//  ChildViewControllers
//
//  Created by yf on 2019/12/6.
//  Copyright © 2019 yf. All rights reserved.
//

import UIKit
import SnapKit

class ViewControllerC: UIViewController {

    var clickBtn:UIButton = {
        let v = UIButton(type: .custom)
        v.setTitle("跳转A", for: .normal)
        v.addTarget(self, action: #selector(onClickAction(_:)), for: .touchUpInside)
        return v
    }()
    
    var presentVC:YXManagerLoginsContainer?
    
    convenience init(superVC:YXManagerLoginsContainer) {
        self.init()
        self.presentVC = superVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(clickBtn)
        clickBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(200)
            make.center.equalToSuperview()
        }
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .green

    }
    
    @objc func onClickAction(_ sender:UIButton) {
        self.presentVC?.transition(to: .A(animation: .right))

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
