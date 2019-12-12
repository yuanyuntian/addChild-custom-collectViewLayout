//
//  YXCollectionViewLayout.swift
//  ChildViewControllers
//
//  Created by yf on 2019/12/12.
//  Copyright © 2019 yf. All rights reserved.
//

import UIKit

protocol YXCollectionViewLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

class YXCollectionViewLayout: UICollectionViewLayout {
    
    weak var delegate:YXCollectionViewLayoutDelegate?
    
    var numberOfColumns:Int = 2
    fileprivate let cellPadding:CGFloat = 6
    
    private var cache:[UICollectionViewLayoutAttributes] = []
    
    private var contentHeight:CGFloat = 0
    
    private var contentWidth:CGFloat {
        guard let collectView = collectionView else {
            return 0
        }
        let insets = collectView.contentInset
        return collectView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        
        guard cache.isEmpty == true,let collectView = collectionView else {
            return
        }
        
        //每个cell宽度
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset:[CGFloat] = []
        
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
        
        for item in 0 ..< collectView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let cellContetnHeight = delegate?.collectionView(collectView, heightForPhotoAtIndexPath: indexPath)
            let height = cellPadding * 2 + (cellContetnHeight ?? 0.0)
            
            // you can set x,y value
            //...
            
            let frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: columnWidth,
                               height: height)
            

            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            
            //保存上一个cell的高度
            yOffset[column] = yOffset[column] + height
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
            
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes:[UICollectionViewLayoutAttributes] = []
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
}
