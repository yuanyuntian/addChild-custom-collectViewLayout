//
//  CollectionViewCell.swift
//  ChildViewControllers
//
//  Created by yf on 2019/12/12.
//  Copyright © 2019 yf. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    lazy var title:UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 28)
        v.textColor = .black
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        self.backgroundColor =  UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
        self.addSubview(title)
        
        setNeedsUpdateConstraints()
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
