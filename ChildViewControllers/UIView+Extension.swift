//
//  UIView+Extension.swift
//  ShangLai
//
//  Created by yosar on 2019/3/29.
//  Copyright © 2019 无忌. All rights reserved.
//

import UIKit

struct HUDIndex {
    /// 子视图上的加载视图
    static let littleViewIndex: Int = 20000
    /// 子视图提示语
    static let littleNoticeIndex: Int = 30000
}

extension UIView {
    
    /// 删除子视图
    ///
    /// - Parameters:
    ///   - subview: 指定子视图
    ///   - all: 是否删除所有子视图
    func removeSubview(_ subview: UIView? = nil, all: Bool = true) {
        if all {
            for subv in self.subviews {
                subv.removeFromSuperview()
            }
            return
        }
        if let subv = subview, let _ = self.subviews.index(of: subv) {
            subview?.removeFromSuperview()
        }
    }
    
    /// 视图当前屏幕位置
    ///
    /// - Returns: frame
    func absulouteFrame(_ view: UIView? = UIApplication.shared.keyWindow) -> CGRect {
        guard let view = view else { return .zero }
        return self.convert(self.frame, to: view)
    }
    
    /// 约束
    ///
    /// - Parameters:
    ///   - fromItem: view1
    ///   - toItem: view2
    ///   - fromAttribute: view1属性
    ///   - toAttribute: view2属性
    ///   - constant: 偏移
    /// - Returns: 约束
    func anchorSubview(from fromItem: Any, to toItem: Any, fromAttribute: NSLayoutConstraint.Attribute, toAttribute: NSLayoutConstraint.Attribute, constant: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: fromItem,
            attribute: fromAttribute,
            relatedBy: .equal,
            toItem: toItem,
            attribute: toAttribute,
            multiplier: 1,
            constant: constant
        )
    }
}

extension UIView {
    


    
    @objc
    func removeViewToastView(_ object: Any?) {
        if Thread.current == Thread.main {
            if let subview = object as? UIView {
                subview.removeFromSuperview()
            }
        } else {
            DispatchQueue.main.async {
                if let subview = object as? UIView {
                    subview.removeFromSuperview()
                }
            }
        }
    }
    
    /// 显示子视图加载视图
    ///
    /// - Returns: 加载视图
    func littleViewLoading() {
        if Thread.current == Thread.main {
            setupLittleView()
        } else {
            DispatchQueue.main.async {
                self.setupLittleView()
            }
        }
        
    }
    /// 小视图加载框
    private func setupLittleView() {
        let vBounds = self.bounds
        let containView = UIView.init(frame: vBounds)
        self.addSubview(containView)
        
        let width: CGFloat = 36
        let height: CGFloat = 36
        let activityContain = UIView.init()
        activityContain.frame = CGRect.init(x: (vBounds.width - width) / 2, y: (vBounds.height - height) / 2, width: width, height: height)
        activityContain.layer.cornerRadius = 5
        activityContain.layer.masksToBounds = true
        activityContain.backgroundColor = UIColor.init(white: 0.1, alpha: 0.8)
        containView.addSubview(activityContain)
        
        let indicator = UIActivityIndicatorView.init(style: .white)
        indicator.startAnimating()
        indicator.frame.origin = CGPoint.init(x: (vBounds.width - indicator.frame.width) / 2, y: (vBounds.height - indicator.frame.height) / 2)
        containView.addSubview(indicator)
        containView.tag = HUDIndex.littleViewIndex
    }
    
    /// 隐藏子视图加载视图
    func hideLittleViewLoading() {
        if Thread.current == Thread.main {
            for subview in self.subviews where subview.tag == HUDIndex.littleViewIndex {
                subview.removeFromSuperview()
            }
        } else {
            DispatchQueue.main.async {
                for subview in self.subviews where subview.tag == HUDIndex.littleViewIndex {
                    subview.removeFromSuperview()
                }
            }
        }
    }
}

extension UIView {
    
    public var benX: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var f = frame
            f.origin.x = newValue
            frame = f
        }
    }
    
    public var benY: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            var f = frame
            f.origin.y = newValue
            frame = f
        }
    }
    public var benMaxX: CGFloat {
        get {
            return frame.origin.x + benWidth
        }
        set {
            var f = frame
            f.origin.x = newValue - benWidth
            frame = f
        }
    }
    
    public var benMaxY: CGFloat {
        get {
            return frame.origin.y + benHeight
        }
        set {
            var f = frame
            f.origin.y = newValue - benHeight
            frame = f
        }
    }
    public var benWidth: CGFloat {
        get {
            return frame.size.width
        }
        set {
            var f = frame
            f.size.width = newValue
            frame = f
        }
    }
    
    public var benHeight: CGFloat {
        get {
            return frame.size.height
        }
        set {
            var f = frame
            f.size.height = newValue
            frame = f
        }
    }
    
    public var benOrigin: CGPoint {
        get {
            return frame.origin
        }
        set {
            var f = frame
            f.origin = newValue
            frame = f
        }
    }
    
    public var benSize: CGSize {
        get {
            return frame.size
        }
        set {
            var f = frame
            f.size = newValue
            frame = f
        }
    }
    
    public var benCenterX: CGFloat {
        get {
            return center.x
        }
        set {
            var c = center
            c.x = newValue
            center = c
        }
    }
    
    public var benCenterY: CGFloat {
        get {
            return center.y
        }
        set {
            var c = center
            c.y = newValue
            center = c
        }
    }
    
    public var benBottom: CGFloat {
        get {
            return frame.maxY
        }
        set {
            benY = newValue - benHeight
        }
    }
    
}


extension UIView {
    /// 根据数据源布局
    ///
    /// - Parameters:
    ///   - items: 数据源
    ///   - row: 列数
    ///   - completion: 事件回调
    //    @discardableResult
    //    func layoutTitleAndImageItems(_ items: [LayoutItem], row: Int, maxColumn: Int = 0, completion: ((_ item: LayoutItem?) -> Void)?) -> Int {
    //        let vw = self.frame.width
    //        var totalWidth: CGFloat = 0
    //        var itemWidth = vw / CGFloat.init(row)
    //        var column: CGFloat = 0
    //        var itemHeight: CGFloat = 0
    //        for i in 0 ..< items.count {
    //            //如超过最大值，则跳出循环
    //            if maxColumn != 0 && Int.init(column) > maxColumn {
    //                break
    //            }
    //            let item = items[i]
    //            itemWidth = ((item.size.width > itemWidth && itemWidth > 0)) ? itemWidth : item.size.width
    //            totalWidth += itemWidth
    //            itemHeight = item.size.height
    //            let itemBtn = ITButton.init(type: .custom)
    //            column = CGFloat.init(i / row)
    //            let remain = CGFloat.init(i % row)
    //            itemBtn.frame = CGRect.init(x: remain * itemWidth, y: column * itemHeight, width: itemWidth, height: itemHeight)
    //            itemBtn.setLayoutTitleAndImageItem(item, completion: completion)
    //            self.addSubview(itemBtn)
    //        }
    //        totalWidth = (totalWidth > AdminScreenWidth) ? AdminScreenWidth : totalWidth
    //        totalWidth = (vw < (itemWidth * CGFloat.init(row))) ? totalWidth : vw
    //        column += 1
    //        self.frame.size = CGSize.init(width: totalWidth, height: column * itemHeight)
    //        return Int.init(column)
    //    }
}



extension UIView {
    public func gradientColor(_ locations: [NSNumber], _ colors: [CGColor], _ startPoint: CGPoint? = CGPoint(x: 0, y: 0), _ endPoint: CGPoint? = CGPoint(x: 0, y: 1)) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = locations

        if let startPoint = startPoint { gradientLayer.startPoint = startPoint }
        if let endPoint = endPoint { gradientLayer.endPoint = endPoint }
        gradientLayer.frame = frame
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    public convenience init(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat, _ bc: UIColor) {
        self.init(frame: CGRect(x:x,y: y ,width: w, height:h))
        self.backgroundColor = bc
    }
}
public extension UIView {
    
    func corner(byRoundingCorners: UIRectCorner = UIRectCorner.allCorners, cornerRadi: CGFloat) {
        self.corner(byRoundingCorners: byRoundingCorners, cornerRadii: CGSize(width: cornerRadi, height: cornerRadi))
    }
    
    func corner(byRoundingCorners: UIRectCorner = UIRectCorner.allCorners, cornerRadii: CGSize) {
        
        let rect = self.bounds
        let bezierPath = UIBezierPath(roundedRect: rect,
                                      byRoundingCorners: byRoundingCorners,
                                      cornerRadii: cornerRadii)
        let maskPath = CAShapeLayer()
//        maskPath.frame = rect
        maskPath.path = bezierPath.cgPath
//        maskPath.shouldRasterize = true
//        maskPath.rasterizationScale = UIScreen.main.scale
        self.layer.mask = maskPath
    }
}
