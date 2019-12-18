//
//  YTLayoutAttributes.swift
//  ChildViewControllers
//
//  Created by yf on 2019/12/18.
//  Copyright © 2019 yf. All rights reserved.
//

import UIKit

final class YTLayoutAttributes: UICollectionViewLayoutAttributes {
    var origin:CGPoint = .zero
    
    override func copy(with zone: NSZone?) -> Any {
      guard let attributes = super.copy(with: zone) as? YTLayoutAttributes else {
        return super.copy(with: zone)
      }
      attributes.origin = origin
      return attributes
    }
    
    override func isEqual(_ object: Any?) -> Bool {
      guard let attributes = object as? YTLayoutAttributes else {
        return false
      }

      if attributes.origin != origin {
          return false
      }
      return super.isEqual(object)
    }
    
}
