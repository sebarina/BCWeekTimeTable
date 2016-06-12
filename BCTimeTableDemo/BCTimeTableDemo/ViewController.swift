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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ap = calendarAppearance()
        ap.firstDay = .Sunday
        weekTableView = WeekTimeTableView(frame: CGRectMake(0, 64, view.frame.width, view.frame.height - 64), appearance: ap)
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
        
        weekTableView?.events = [event1, event2, event3, event4]
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
