//
//  YXCollectViewHeaderView.swift
//  ChildViewControllers
//
//  Created by yf on 2019/12/13.
//  Copyright © 2019 yf. All rights reserved.
//

import UIKit

class YXCollectViewHeaderView: UICollectionReusableView {
        
    lazy var title:UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 28)
        v.textColor = .black
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(title)
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        title.snp.updateConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}
