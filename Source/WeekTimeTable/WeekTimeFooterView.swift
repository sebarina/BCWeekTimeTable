//
//  WeekTimeFooterView.swift
//  BocaiConsultant
//
//  Created by Sebarina Xu on 6/7/16.
//  Copyright © 2016 liufan. All rights reserved.
//

import UIKit

protocol ReusableView {
}

extension UITableViewCell : ReusableView {}
extension UICollectionViewCell : ReusableView {}
extension ReusableView where Self: UIView {
    static var reuseIdentifier : String {
        return String(self)
    }
}

public class WeekTimeFooterView: UICollectionReusableView, ReusableView {
    private var textLabel : UILabel?
    private var line : UIView?
    public var lineColor : UIColor? {
        didSet {
            if lineColor != nil {
                line?.backgroundColor = lineColor!
            }
        }
    }
    public var titleWidth : CGFloat? {
        didSet {
            if titleWidth != nil {
                textLabel?.frame.size.width = titleWidth! - 5
                line?.frame.origin.x = titleWidth!
                line?.frame.size.width = frame.width - titleWidth!
            }
        }
    }
    public var titleColor : UIColor  {
        get {
            return textLabel?.textColor ?? UIColor(red: 0x2E/255.0, green: 0x3D/255.0, blue: 0x50/255.0, alpha: 1)
        }
        set {
            textLabel?.textColor = newValue
        }
    }
    
    public var hour : String {
        get {
            return textLabel?.text ?? ""
        }
        set {
            textLabel?.text = newValue
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        textLabel = UILabel(frame: CGRectMake(0, 0, 35, 16))
        textLabel?.textAlignment = .Right
        textLabel?.textColor = UIColor.blackColor()
        textLabel?.font = UIFont.systemFontOfSize(12)
        textLabel?.text = "24"
        addSubview(textLabel!)
        
        line = UIView(frame: CGRectMake(40, 7, frame.width-40, 1))
        line?.backgroundColor = UIColor(red: 187.0/255.0, green: 187.0/255.0, blue: 187.0/255.0, alpha: 1)
        addSubview(line!)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
