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
        v.register(YXCollectViewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        v.register(YXCollectViewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
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
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? YXCollectViewHeaderView {
                headerView.backgroundColor = .red
                return headerView
            }
            
        }else if kind == UICollectionView.elementKindSectionFooter {
            if let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as? YXCollectViewHeaderView {
                footerView.backgroundColor = .yellow
                return footerView
            }
        }
        return UICollectionReusableView()
    }
}

extension ViewControllerA:YXCollectionViewLayoutDelegate{
    
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Int.randomIntNumber(lower: 100, upper: 200))
    }
    
    func collectionView(_ collectionView:UICollectionView,_ layout:YXCollectionViewLayout, referenceHeightForHeaderInSection section:NSInteger) -> CGFloat {
        
//        if section == 0 {
//            return 0
//        }else if section == 1{
//            return 100
//        }
//        return 0
        return CGFloat(Int.randomIntNumber(lower: 50, upper: 100))
    }
    
    func collectionView(_ collectionView:UICollectionView,_ layout:YXCollectionViewLayout, referenceHeightForFooterInSection section:NSInteger) -> CGFloat {
        return  CGFloat(Int.randomIntNumber(lower: 50, upper: 100))
    }
    
    func columnNumberAtSection(in collectionView: UICollectionView) -> NSInteger {
        return  3
    }

    func collectionView(_ collectionView:UICollectionView,_ layout:YXCollectionViewLayout, spacingWithLastSectionForSectionAtIndex section:NSInteger) -> CGFloat {
        return  CGFloat(Int.randomIntNumber(lower: 50, upper: 100))
    }
    
    func collectionView(_ collectionView:UICollectionView,_ layout:YXCollectionViewLayout, insetForItemAtIndex section:NSInteger) -> CGSize {
        return CGSize(width: 5, height: 5)
    }

}
