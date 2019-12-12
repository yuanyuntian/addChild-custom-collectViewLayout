//
//  ViewController.swift
//  ChildViewControllers
//
//  Created by yf on 2019/12/5.
//  Copyright © 2019 yf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.pushViewController(YXManagerLoginsContainer(), animated: true)
    }


}

