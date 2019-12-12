//
//  ViewControllerA.swift
//  ChildViewControllers
//
//  Created by yf on 2019/12/6.
//  Copyright © 2019 yf. All rights reserved.
//

import UIKit
import SnapKit


class ViewControllerA: UIViewController {
    
    
    lazy var collectView:UICollectionView = {
        let layout = YXCollectionViewLayout()
        layout.delegate = self
        layout.numberOfColumns = 3
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        v.backgroundColor = .clear
        v.dataSource = self
        v.delegate = self
        v.backgroundColor = .gray
        v.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
//        v.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 10, right: 0)
        return v
    }()

    var clickBtn:UIButton = {
        let v = UIButton(type: .custom)
        v.setTitle("跳转B", for: .normal)
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


        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        self.view.addSubview(collectView)
        collectView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        view.addSubview(clickBtn)
        clickBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.center.equalToSuperview()
        }
        
    }
    
    @objc func onClickAction(_ sender:UIButton) {
        
        self.presentVC?.transition(to: .B(animation: .right))
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

extension ViewControllerA:UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath as IndexPath) as! CollectionViewCell
        cell.title.text = "\(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.alpha = 0
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1
        }
//        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
//            cell.alpha = 1
//        }, completion: nil)
        
    }
    
    
}

extension ViewControllerA:YXCollectionViewLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 100.0//CGFloat(Int.randomIntNumber(lower: 100, upper: 200))
    }
}
