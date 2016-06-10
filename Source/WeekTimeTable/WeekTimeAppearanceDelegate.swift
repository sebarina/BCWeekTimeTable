//
//  WeekTimeAppearanceDelegate.swift
//  BocaiConsultant
//
//  Created by Sebarina Xu on 6/7/16.
//  Copyright © 2016 liufan. All rights reserved.
//

import UIKit


@objc public protocol WeekTimeAppearanceDelegate {
    optional func weekTimeTableLineColor() -> UIColor
    optional func weekTimeTableDashlineColor() -> UIColor
    optional func weekTimeTableEventTitleColor() -> UIColor
    optional func weekTimeTableTimeColor() -> UIColor
    optional func weekTimeTableTimeWidth() -> CGFloat
    optional func weekTimeAddButtonBgColor() -> UIColor
    optional func weekTimeAddButtonImage() -> UIImage
    optional func weekTimeAddButtonTitle() -> String
    
    
}

infix operator ~> { }
public func ~><T: Any>(inout lhs: T, rhs: T?) -> T {
    if rhs != nil {
        lhs = rhs!
    }
    
    return lhs
}