//
//  WeekTimeAppearance.swift
//  BocaiConsultant
//
//  Created by Sebarina Xu on 6/7/16.
//  Copyright © 2016 liufan. All rights reserved.
//

import UIKit


public struct WeekTimeAppearance {
    public var lineColor : UIColor = UIColor.colorFromCode(0xBBBBBB)
    public var dashLineColor : UIColor = UIColor.colorFromCode(0x9A9A9A).colorWithAlphaComponent(0.8)
    public var eventTitleColor : UIColor = UIColor.colorFromCode(0x2E3D50)
    public var timeColor : UIColor = UIColor.colorFromCode(0x2E3D50)
    public var addButtonBgColor : UIColor = UIColor.colorFromCode(0x66ccff)
    public var addButtonText : String = ""
    public var addButtonImage : UIImage = UIImage()
    public var startHour : Int = 0
    public var endHour : Int = 24
    
    init() {
        
    }
}

extension UIColor {
    public static func colorFromCode(code: Int) -> UIColor {
        let red = CGFloat(((code & 0xFF0000) >> 16)) / 255
        let green = CGFloat(((code & 0xFF00) >> 8)) / 255
        let blue = CGFloat((code & 0xFF)) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}