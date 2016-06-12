//
//  CalendarViewOptions.swift
//  BocaiConsultant
//
//  Created by Sebarina Xu on 6/6/16.
//  Copyright © 2016 liufan. All rights reserved.
//pr

import UIKit
import CVCalendar
public class BCCalendarViewAppearance : NSObject {
    public var spaceBetweenDays : CGFloat = 2
    public var currentDaySelectedBgColor : UIColor = UIColor.colorFromCode(0x66ccff)
    public var currentDaySelectedTextColor : UIColor = UIColor.whiteColor()
    public var currentDayTextColor : UIColor = UIColor.redColor()
    public var currentDayBgColor : UIColor = UIColor.lightGrayColor()
    public var weekDaySelectedBgColor : UIColor = UIColor.colorFromCode(0x66ccff)
    public var weekDaySelectedTextColor : UIColor = UIColor.whiteColor()
    public var weekDayInTextColor : UIColor = UIColor.colorFromCode(0x2E3D50)
    public var weekDayOutTextColor : UIColor = UIColor.lightGrayColor()
    public var currentDayTextSize : CGFloat = 14
    public var weekDayTextSize : CGFloat = 14
    public var dayOfWeekTextColor : UIColor = UIColor.grayColor()
    public var firstDay : Weekday = .Monday
    public var weekdaySymbolType : WeekdaySymbolType = .Short
    public var dayOfWeekTextUppercase : Bool = true
}

@objc public protocol BCCalendarViewDelegate {
    optional func didSelectDayView(date: DayView, animationDidFinish: Bool)
    optional func currentDateUpdated(date: CVDate)
    optional func didShowNextMonthView(date: NSDate)
    optional func didShowPreviousMonthView(date: NSDate)
}
