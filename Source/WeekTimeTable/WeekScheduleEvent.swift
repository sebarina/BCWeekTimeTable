//
//  WeekScheduleEvent.swift
//  BocaiConsultant
//
//  Created by Sebarina Xu on 6/7/16.
//  Copyright © 2016 liufan. All rights reserved.
//

import UIKit

public struct WeekScheduleEvent<T> {
    public var startDate : NSDate
    public var endDate : NSDate
    public var startSeconds : Double
    public var endSeconds : Double
    public var eventColor : UIColor
    public var eventTitle : String
    public var customValue : T?
    
    public init(startDate: NSDate, endDate: NSDate, eventColor: UIColor, eventTitle: String, customValue: T?) {
        self.startDate = startDate
        self.endDate = endDate
        self.eventColor = eventColor
        self.eventTitle = eventTitle
        self.customValue = customValue
        let comp1 = TimeUtil.getDateComponent(startDate)
        self.startSeconds = Double(comp1.hour*3600 + comp1.minute*60)
        let comp2 = TimeUtil.getDateComponent(endDate)
        self.endSeconds = Double(comp2.hour*3600 + comp2.minute*60)
    }
    
}

class EventButton : UIButton {
    var customEvent : AnyObject?
}