//
//  ViewController.swift
//  BCTimeTableDemo
//
//  Created by Sebarina Xu on 6/10/16.
//  Copyright © 2016 bocai. All rights reserved.
//

import UIKit
import BCWeekTimeTable

class ViewController: UIViewController {
    var weekTableView : WeekTimeTableView?
    private let queue = dispatch_queue_create("com.aschuch.cache.diskQueue", DISPATCH_QUEUE_CONCURRENT)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ap = calendarAppearance()
        ap.firstDay = .Sunday
        weekTableView = WeekTimeTableView(frame: CGRectMake(0, 20, view.frame.width, view.frame.height-20), appearance: ap)
        weekTableView?.weekTimeAppearanceDelegate = self
        weekTableView?.weekTimeDelegate = self
        view.addSubview(weekTableView!)
        
        
    }


}

extension ViewController : WeekTimeTableDelegate {
    func weekTimeTableAddEvent(starTime: NSDate, endTime: NSDate, addButton: UIButton) {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm"
        format.timeZone = NSTimeZone.localTimeZone()
        print("start time: " + format.stringFromDate(starTime))
        print("end time: " + format.stringFromDate(endTime))
    }
    
    func weekTimeTableDidSelectEvent(event: AnyObject?) {
        var test = "just for testing"
        dispatch_sync(queue) { 
            sleep(5)
            test = "just after update"
        }
        print(test)
    }
    
    func weekTimeWeekTimeUpdated(starTime: NSDate) {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm"
        format.timeZone = NSTimeZone.localTimeZone()
        print("start time: " + format.stringFromDate(weekTableView!.startTime))
        print("end time: " + format.stringFromDate(weekTableView!.endTime))
        let event1 = WeekScheduleEvent<NSObject>(startDate: NSDate(), endDate: NSDate().dateByAddingTimeInterval(3600), eventColor: UIColor.blueColor().colorWithAlphaComponent(0.6), eventTitle: "测试事件", customValue: Reservation())
        
        
        let event2 = WeekScheduleEvent<NSObject>(startDate: NSDate().dateByAddingTimeInterval(-7200), endDate: NSDate().dateByAddingTimeInterval(-3600), eventColor: UIColor.greenColor().colorWithAlphaComponent(0.6), eventTitle: "测试事件1", customValue: Reservation())
        
        let event3 = WeekScheduleEvent<NSObject>(startDate: NSDate().dateByAddingTimeInterval(-1800), endDate: NSDate().dateByAddingTimeInterval(1800), eventColor: UIColor.orangeColor().colorWithAlphaComponent(0.6), eventTitle: "测试事件2", customValue: Reservation())
        
        let event4 = WeekScheduleEvent<NSObject>(startDate: NSDate().dateByAddingTimeInterval(-3600*2.5), endDate: NSDate().dateByAddingTimeInterval(-3600*1.5), eventColor: UIColor.redColor().colorWithAlphaComponent(0.6), eventTitle: "测试事件3", customValue: Reservation())
        
        let event5 = WeekScheduleEvent<NSObject>(startDate: format.dateFromString("2016-6-15 08:00")!, endDate: format.dateFromString("2015-6-15 09:00")!, eventColor: UIColor.blueColor().colorWithAlphaComponent(0.6), eventTitle: "测试事件5", customValue: nil)
        let event6 = WeekScheduleEvent<NSObject>(startDate: format.dateFromString("2016-6-13 21:00")!, endDate: format.dateFromString("2015-6-13 22:00")!, eventColor: UIColor.blueColor().colorWithAlphaComponent(0.6), eventTitle: "测试事件6", customValue: nil)
        
        let event7 = WeekScheduleEvent<NSObject>(startDate: format.dateFromString("2016-6-15 07:00")!, endDate: format.dateFromString("2015-6-15 09:00")!, eventColor: UIColor.blueColor().colorWithAlphaComponent(0.6), eventTitle: "测试事件7", customValue: nil)
        let event8 = WeekScheduleEvent<NSObject>(startDate: format.dateFromString("2016-6-13 21:00")!, endDate: format.dateFromString("2015-6-13 23:00")!, eventColor: UIColor.blueColor().colorWithAlphaComponent(0.6), eventTitle: "测试事件8", customValue: nil)
        
        weekTableView?.events = [event1, event2, event3, event4, event5, event6, event7, event8]
    }
}

extension ViewController {
    func calendarAppearance() -> BCCalendarViewAppearance {
        let appearance = BCCalendarViewAppearance()
        appearance.currentDayTextColor = UIColor.brownColor()
        appearance.currentDaySelectedBgColor = UIColor.greenColor()
        appearance.currentDayBgColor = UIColor.whiteColor()
        appearance.weekDaySelectedBgColor = UIColor.greenColor()
        return appearance
    }
}

extension ViewController : WeekTimeAppearanceDelegate {
    func weekTimeAddButtonTitle() -> String {
        return "+"
    }
    
    func weekTimeAddButtonBgColor() -> UIColor {
        return UIColor.brownColor()
    }
    
    func weekTimeTableDashlineColor() -> UIColor {
        return UIColor.purpleColor()
    }
    
    func weekTimeTableStartHour() -> Int {
        return 8
    }
    
    func weekTimeTableEndHour() -> Int {
        return 22
    }
}


class Reservation : NSObject {
    var id = ""
    var courseId = ""
    var courseName = ""
    var traineeId = ""
    var traineeName = ""
    var date = ""
    var startTime = ""
    var duration = 0
    var createType = ""
    var pictures = [""]
    var status = 1
    var statusStr = ""
    var remindTypeStr = ""
    var remindType = ""
    var remindIdentity = ""
    
    var eventType = ""
    var eventTypeStr = ""
    var endTime = ""
    var comment = ""
    
    override init() {}
    
    
    
    
    
}
