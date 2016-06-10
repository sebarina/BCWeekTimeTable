//
//  TimeUtil.swift
//  WeekTimeTable
//
//  Created by Sebarina Xu on 6/7/16.
//  Copyright © 2016 bocai. All rights reserved.
//

import Foundation

public class BCDateComponent {
    public var year : Int
    public var month : Int
    public var day : Int
    public var weekDay : Int
    public var hour : Int
    public var minute : Int
    public var second : Int
    
    public init(year: Int, month: Int, day: Int, weekDay: Int, hour: Int, minute: Int, second: Int) {
        self.year = year
        self.month = month
        self.day = day
        self.weekDay = weekDay
        self.hour = hour
        self.minute = minute
        self.second = second
    }
}

class TimeUtil {
    static var localDateFormat : NSDateFormatter {
        let format = NSDateFormatter()
        format.timeZone = NSTimeZone.localTimeZone()
        return format
    }
    
    static var localCalendar : NSCalendar {
        let calendar = NSCalendar.currentCalendar()
        calendar.timeZone = NSTimeZone.localTimeZone()
        return calendar
    }

    
    static func getDateComponent(date: NSDate) -> BCDateComponent {
        let components : NSDateComponents = localCalendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, .Day, .Hour, .Minute, .Second, .Weekday], fromDate: date)
        
        return BCDateComponent(year: components.year, month: components.month, day: components.day, weekDay: components.weekday, hour: components.hour, minute: components.minute, second: components.second)
        
    }
    
    static func getTimeStartDate(date: NSDate) -> NSDate {
        let component = getDateComponent(date)
        let offsetSeconds = Double(component.hour*3600 + component.minute*60 + component.second)
        return date.dateByAddingTimeInterval(-offsetSeconds)
        
    }
    
    static func getDateStr(date: NSDate) -> String {
        let dateFormatter = localDateFormat
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.stringFromDate(date)
    }
    
    static func getWeekStartDate(date: NSDate) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        calendar.firstWeekday = 2
        calendar.timeZone = NSTimeZone.localTimeZone()
        let currentDateComponents = calendar.components([.YearForWeekOfYear, .WeekOfYear ], fromDate: date)
        return calendar.dateFromComponents(currentDateComponents) ?? date
    }
}