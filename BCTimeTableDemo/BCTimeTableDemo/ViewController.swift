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
        weekTableView = WeekTimeTableView(frame: CGRectMake(0, 64, view.frame.width, view.frame.height - 64), appearance: calendarAppearance())
        weekTableView?.weekTimeAppearanceDelegate = self
        weekTableView?.weekTimeDelegate = self
        view.addSubview(weekTableView!)
        
        let event1 = WeekScheduleEvent(startDate: NSDate(), endDate: NSDate().dateByAddingTimeInterval(3600), eventColor: UIColor.blueColor().colorWithAlphaComponent(0.6), eventTitle: "测试事件", customValue: nil)
        
        
        let event2 = WeekScheduleEvent(startDate: NSDate().dateByAddingTimeInterval(3600*18), endDate: NSDate().dateByAddingTimeInterval(3600*19), eventColor: UIColor.greenColor().colorWithAlphaComponent(0.6), eventTitle: "测试事件1", customValue: nil)
        
        let event3 = WeekScheduleEvent(startDate: NSDate().dateByAddingTimeInterval(-3600*24), endDate: NSDate().dateByAddingTimeInterval(-3600*23), eventColor: UIColor.orangeColor().colorWithAlphaComponent(0.6), eventTitle: "测试事件2", customValue: nil)
        
        let event4 = WeekScheduleEvent(startDate: NSDate().dateByAddingTimeInterval(-3600*0.5), endDate: NSDate().dateByAddingTimeInterval(3600*0.5), eventColor: UIColor.redColor().colorWithAlphaComponent(0.6), eventTitle: "测试事件3", customValue: nil)
        
        weekTableView?.events = [event1, event2, event3, event4]
    }


}

extension ViewController : WeekTimeTableDelegate {
    func weekTimeTableAddEvent(starTime: NSDate, endTime: NSDate) {
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
    }
}

extension ViewController {
    func calendarAppearance() -> CalendarViewAppearance {
        let appearance = CalendarViewAppearance()
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
    
    func weekTimeTableTimeWidth() -> CGFloat {
        return 40
    }
}
