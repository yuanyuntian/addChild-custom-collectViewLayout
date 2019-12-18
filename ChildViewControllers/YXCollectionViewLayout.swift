//
//  YXCollectionViewLayout.swift
//  ChildViewControllers
//
//  Created by yf on 2019/12/12.
//  Copyright © 2019 yf. All rights reserved.
//

import UIKit

@objc protocol YXCollectionViewLayoutDelegate: NSObjectProtocol {
    
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat
    
    
    /// header size
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - layout: <#layout description#>
    ///   - section: <#section description#>
    @objc optional func collectionView(_ collectionView:UICollectionView,_ layout:YXCollectionViewLayout, referenceHeightForHeaderInSection section:NSInteger) -> CGFloat
    
    
    
    /// footer suze
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - layout: <#layout description#>
    ///   - section: <#section description#>
    @objc optional func collectionView(_ collectionView:UICollectionView,_ layout:YXCollectionViewLayout, referenceHeightForFooterInSection section:NSInteger) -> CGFloat
    
    
    

    
    /// 每个区的边距
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - layout: <#layout description#>
    ///   - section: <#section description#>
    @objc optional func collectionView(_ collectionView:UICollectionView,_ layout:YXCollectionViewLayout, insetForItemAtIndex section:NSInteger) -> CGSize
    
    
    
    /// 行距
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - layout: <#layout description#>
    ///   - section: <#section description#>
    @objc optional func collectionView(_ collectionView:UICollectionView,_ layout:YXCollectionViewLayout, lineSpacingForSectionAtIndex section:NSInteger) -> NSInteger
    
    
    /// 列间距
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - layout: <#layout description#>
    ///   - section: <#section description#>
    @objc optional func collectionView(_ collectionView:UICollectionView,_ layout:YXCollectionViewLayout, interitemSpacingForSectionAtIndex section:NSInteger) -> NSInteger
    
    
    
    /// 区头和上个区区尾的间距
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - layout: <#layout description#>
    ///   - section: <#section description#>
    @objc optional func collectionView(_ collectionView:UICollectionView,_ layout:YXCollectionViewLayout, spacingWithLastSectionForSectionAtIndex section:NSInteger) -> CGFloat
    
    
    
    /// 每个section 多少列
    /// - Parameter collectionView: <#collectionView description#>
    @objc optional func  columnNumberAtSection(in collectionView: UICollectionView) -> NSInteger
}

class YXCollectionViewLayout: UICollectionViewLayout {
    
    weak var delegate:YXCollectionViewLayoutDelegate?
    
    var numberOfColumns:Int = 2
    private var cellPaddingSize:CGSize = CGSize.zero
    
    private var cache:[YTLayoutAttributes] = []
    
    private var contentHeight:CGFloat = 0
    
    private var headerReferenceHeight:CGFloat?
    
    private var footerReferenceHeight:CGFloat?
    
    private var spacingWithLastSection:CGFloat = 50//每个section的间距（上个尾部和下个头部的间距）
        
    private var columnWidth:CGFloat = 0
    
    private var cellHeight:CGFloat = 0//高度
    
    private var zIndex = 0
    
    private var contentOffset: CGPoint {
      return collectionView!.contentOffset
    }
    

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
        
        
        self.numberOfColumns = (self.delegate?.columnNumberAtSection?(in: collectView))!
        
        self.columnWidth = CGFloat(NSInteger(contentWidth) / self.numberOfColumns)

        
        for section in 0 ..< collectView.numberOfSections {
            
            self.headerReferenceHeight = self.delegate?.collectionView?(collectView, self, referenceHeightForHeaderInSection: section)
            self.footerReferenceHeight = self.delegate?.collectionView?(collectView, self, referenceHeightForFooterInSection: section)
            self.spacingWithLastSection = self.delegate?.collectionView?(collectView, self, spacingWithLastSectionForSectionAtIndex: section) ?? 50
            self.cellPaddingSize = self.delegate?.collectionView?(collectView, self, insetForItemAtIndex: section) ?? CGSize.zero
            let indexPath = IndexPath(index: section)
            let headerAttribute:YTLayoutAttributes = YTLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: indexPath)
            self.setRepresentedElementElement(size: CGSize(width: contentWidth, height: self.headerReferenceHeight ?? 0), attributes: headerAttribute)
            var yOffset: [CGFloat] = .init(repeating: contentHeight, count: numberOfColumns)
            for item in 0 ..< collectView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                self.cellHeight = delegate?.collectionView(collectView, heightForItemAt: indexPath) ?? 0
                // you can set x,y value
                //...
                
                let frame = CGRect(x: xOffset[column],
                                   y: yOffset[column],
                                   width: self.columnWidth,
                                   height: self.cellHeight)
                

                let insetFrame = frame.insetBy(dx: self.cellPaddingSize.width, dy: self.cellPaddingSize.height)

                let attributes = YTLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                attributes.zIndex = zIndex
                cache.append(attributes)
                
                contentHeight = max(contentHeight, frame.maxY)
                
                //保存上一个cell的高度
                yOffset[column] = yOffset[column] + self.cellHeight
                column = column < (numberOfColumns - 1) ? (column + 1) : 0
                zIndex += 1
                    
            }
            let footerAttribute:YTLayoutAttributes = YTLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, with: indexPath)
            footerAttribute.frame = CGRect(x: 0, y: contentHeight, width: contentWidth, height: self.footerReferenceHeight ?? 0)
            self.setRepresentedElementElement(size: CGSize(width: contentWidth, height: self.footerReferenceHeight ?? 0), attributes: footerAttribute)
        }
        
        //重置header部分的zIndex
        for attributes in cache {
            var sectionHeadersZIndex = self.zIndex
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader {
                attributes.zIndex = sectionHeadersZIndex
                sectionHeadersZIndex += 1
            }
        }
        
    }
    
    private func setRepresentedElementElement(size:CGSize, attributes:YTLayoutAttributes) {
        guard size != .zero else { return }
        attributes.origin = CGPoint(x: 0, y: contentHeight)
        attributes.frame = CGRect(origin: attributes.origin, size: size)
        attributes.zIndex = zIndex
        self.zIndex += 1
        
        contentHeight = attributes.frame.maxY
        cache.append(attributes)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes:[UICollectionViewLayoutAttributes] = []
        
        for attributes in cache {
            attributes.transform = .identity
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader {
//                var att:YTLayoutAttributes = (attributes as? YTLayoutAttributes)!
//                print("\(contentOffset.y)   \(attributes.frame.origin.y)   \(min(1000, max(0, contentOffset.y - attributes.frame.origin.y)))   \(att.origin.y)")
                attributes.transform = CGAffineTransform(translationX: 0, y:min(1000, max(0, contentOffset.y - attributes.origin.y)))
            }

            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
    
    
    //返回对应的header和footer的attributes
//    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        var attribute:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, with: indexPath)
//        if elementKind == UICollectionView.elementKindSectionHeader {
//            self.headerReferenceSize = self.delegate?.collectionView!(self.collectionView!, self, referenceSizeForHeaderInSection: indexPath.section)
//        } else if elementKind == UICollectionView.elementKindSectionFooter {
//
//        }
//        return attribute
//    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        if newBounds == collectionView?.bounds {
//            return true
//        }
//        return false
        return true
    }

}
