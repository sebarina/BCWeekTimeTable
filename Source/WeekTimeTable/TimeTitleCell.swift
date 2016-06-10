//
//  TimeTitleCell.swift
//  BocaiConsultant
//
//  Created by Sebarina Xu on 6/7/16.
//  Copyright © 2016 liufan. All rights reserved.
//

import UIKit

public class TimeTitleCell: UICollectionViewCell {
    
    public var titleColor : UIColor  {
        get {
            return textLabel?.textColor ?? UIColor(red: 0x2E/255.0, green: 0x3D/255.0, blue: 0x50/255.0, alpha: 1)
        }
        set {
            textLabel?.textColor = newValue
        }
    }
    private var textLabel : UILabel?
    
    public var time : String {
        get {
            return textLabel?.text ?? ""
        }
        set {
            textLabel?.text = newValue
        }
    }
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        textLabel = UILabel(frame: CGRectMake(0,0,frame.width-5,16))
        textLabel?.textAlignment = .Right
        textLabel?.textColor = titleColor
        textLabel?.font = UIFont.systemFontOfSize(12)
        addSubview(textLabel!)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
