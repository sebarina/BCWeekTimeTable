//
//  WeekTimeCell.swift
//  BocaiConsultant
//
//  Created by Sebarina Xu on 6/7/16.
//  Copyright © 2016 liufan. All rights reserved.
//

import UIKit

public class WeekTimeCell: UICollectionViewCell {
    public var lineColor : UIColor = UIColor(red: 187.0/255.0, green: 187.0/255.0, blue: 187.0/255.0, alpha: 1)
    public var dashLineColor : UIColor = UIColor(red: 154.0/255.0, green: 154.0/255.0, blue: 154.0/255.0, alpha: 1)

    
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let context = UIGraphicsGetCurrentContext()
        CGContextBeginPath(context)
        CGContextSetFillColorWithColor(context, (backgroundColor ?? UIColor.whiteColor()).CGColor)
        CGContextFillRect(context, rect)
        
        CGContextSetLineWidth(context, 1)
        CGContextSetLineDash(context, 0, [1,0], 2)
        CGContextMoveToPoint(context, 0, 7)
        CGContextAddLineToPoint(context, frame.width, 7)
        CGContextSetStrokeColorWithColor(context, lineColor.CGColor)
        CGContextStrokePath(context)
        
        CGContextSetLineWidth(context, 0.8)
        CGContextSetStrokeColorWithColor(context, dashLineColor.CGColor)        
        CGContextSetLineDash(context, 0, [1,2], 2)
        CGContextMoveToPoint(context, 0, frame.height/2 + 7)
        CGContextAddLineToPoint(context, frame.width, frame.height/2 + 7)
        CGContextStrokePath(context)
        
        CGContextClosePath(context)
        
    }
}
