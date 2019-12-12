//
//  Int+Extension.swift
//  ShangLai
//
//  Created by yosar on 2019/9/4.
//  Copyright © 2019 无忌. All rights reserved.
//

import Foundation

import UIKit

extension Int {
    func switchToString() -> String {
        if self < 1000 {
            return String(self)
        }else {
            if self % 1000 == 0 {
                return String(format: "%.0fk", CGFloat(self) * CGFloat(0.001))
            }else {
                return String(format: "%.1fk", CGFloat(self) * CGFloat(0.001))
            }
        }
    }
}
public extension Int {
    /*这是一个内置函数
     lower : 内置为 0，可根据自己要获取的随机数进行修改。
     upper : 内置为 UInt32.max 的最大值，这里防止转化越界，造成的崩溃。
     返回的结果： [lower,upper) 之间的半开半闭区间的数。
     */
    static func randomIntNumber(lower: Int = 0,upper: Int = Int(UInt32.max)) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower)))
    }
    /**
     生成某个区间的随机数
     */
    static func randomIntNumber(range: Range<Int>) -> Int {
        return randomIntNumber(lower: range.lowerBound, upper: range.upperBound)
    }
}
extension String {
    func toDecimal() -> Decimal {
        guard let result = Decimal(string: self) else { return 0 }
        return result
    }
}
