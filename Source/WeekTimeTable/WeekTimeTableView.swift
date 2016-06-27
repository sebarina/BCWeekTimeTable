//
//  WeekTimeTableView.swift
//  WeekTimeTable
//
//  Created by Sebarina Xu on 6/8/16.
//  Copyright © 2016 bocai. All rights reserved.
//

import UIKit
import CVCalendar

public class WeekTimeTableView: UIView {
    public var calendarView : BCCalendarView?
    public var collectionView : WeekTimeCollectionView?
    public var yearLabel : UILabel?
    public var monthLabel : UILabel?
    public var calendarAppearance : BCCalendarViewAppearance!
    public var selectedDate : NSDate = NSDate()
    
    public weak var weekTimeAppearanceDelegate : WeekTimeAppearanceDelegate? {
        didSet {
            collectionView?.appearanceDelegate = weekTimeAppearanceDelegate
        }
    }
    
    public weak var weekTimeDelegate : WeekTimeTableDelegate? {
        didSet {
            collectionView?.weekTimeDelegate = weekTimeDelegate
        }
    }
    
    public var endTime : NSDate {
        return startTime.dateByAddingTimeInterval(6*24*3600)
    }
    
    public var startTime : NSDate {
        return collectionView?.startDate ?? NSDate()
    }
    
    public var events : [WeekScheduleEvent]? {
        didSet {
            if events != nil {
                var tempEvents : [[WeekScheduleEvent]] = [
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    []
                ]
                for event in events! {
                    let weekDay = (TimeUtil.getDateComponent(event.startDate).weekDay + 7 - calendarAppearance.firstDay.rawValue) % 7
                    tempEvents[weekDay].append(event)
                    
                }
                
                for i in 0 ..< tempEvents.count {
                    let tempEvent = tempEvents[i]
                    tempEvents[i] = tempEvent.sort({ (event1, event2) -> Bool in
                        if event1.startSeconds < event2.startSeconds {
                            return true
                        }
                        return false
                    })
                }
                collectionView?.events = tempEvents
            }
            
            
        }
    }
    
    public init(frame: CGRect, appearance: BCCalendarViewAppearance = BCCalendarViewAppearance()) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        self.calendarAppearance = appearance
        calendarView = BCCalendarView(frame: CGRectZero, appearance: appearance)
        calendarView?.calendarDelegate = self
        calendarView?.translatesAutoresizingMaskIntoConstraints = false
        let cl = NSLayoutConstraint(item: calendarView!, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 40.0)
        let ct = NSLayoutConstraint(item: calendarView!, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0)
        let cw = NSLayoutConstraint(item: calendarView!, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1.0, constant: 0)
        let ch = NSLayoutConstraint(item: calendarView!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 68.0)
        addSubview(calendarView!)
        NSLayoutConstraint.activateConstraints([ct, cw, cl, ch])
        
        
        let compoent : BCDateComponent = TimeUtil.getDateComponent(NSDate())
        
        yearLabel = UILabel(frame: CGRect.zero)
        yearLabel?.textAlignment = .Center
        yearLabel?.textColor = UIColor.darkGrayColor()
        yearLabel?.font = UIFont.systemFontOfSize(12)
        yearLabel?.text = String(compoent.year)
        yearLabel?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(yearLabel!)
        
        let yl = NSLayoutConstraint(item: yearLabel!, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0)
        let yt = NSLayoutConstraint(item: yearLabel!, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 8)
        let yw = NSLayoutConstraint(item: yearLabel!, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 40)
        let yh = NSLayoutConstraint(item: yearLabel!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 24)
        NSLayoutConstraint.activateConstraints([yl, yt, yw, yh])
        
        monthLabel = UILabel(frame: CGRectZero)
        monthLabel?.textAlignment = .Center
        monthLabel?.textColor = appearance.weekDaySelectedBgColor
        monthLabel?.font = UIFont.systemFontOfSize(16)
        monthLabel?.text = String(compoent.month) + "月"
        monthLabel?.translatesAutoresizingMaskIntoConstraints = false
        let ml = NSLayoutConstraint(item: monthLabel!, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0)
        let mt = NSLayoutConstraint(item: monthLabel!, attribute: .Top, relatedBy: .Equal, toItem: yearLabel!, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let mw = NSLayoutConstraint(item: monthLabel!, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 40)
        let mh = NSLayoutConstraint(item: monthLabel!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 36)
        addSubview(monthLabel!)
        NSLayoutConstraint.activateConstraints([ml, mt, mw, mh])
        
        collectionView = WeekTimeCollectionView(frame: CGRect.zero, timeWidth: 40, firstWeekDay: appearance.firstDay.rawValue)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView!)        
        let col = NSLayoutConstraint(item: collectionView!, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0)
        let cot = NSLayoutConstraint(item: collectionView!, attribute: .Top, relatedBy: .Equal, toItem: calendarView!, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let cor = NSLayoutConstraint(item: collectionView!, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0)
        let cob = NSLayoutConstraint(item: collectionView!, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0)
        NSLayoutConstraint.activateConstraints([col, cot, cor, cob])
        
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        collectionView?.scrollToCurrentTime()
        weekTimeDelegate?.weekTimeWeekTimeUpdated?(startTime)
    }
    
    public func goToDate(date: NSDate) {
        calendarView?.calendarView?.toggleViewWithDate(date)
        
    }
}


extension WeekTimeTableView : BCCalendarViewDelegate {
    public func didSelectDayView(dayView: DayView, animationDidFinish: Bool) {
        selectedDate = dayView.date.convertedDate() ?? NSDate()
        let start = TimeUtil.getWeekStartDate(dayView.date.convertedDate() ?? NSDate(), firstWeekDay: calendarAppearance.firstDay.rawValue)
        if collectionView!.startDate != start {
            collectionView?.startDate = start
            weekTimeDelegate?.weekTimeWeekTimeUpdated?(start)
        }
        
        
    }
    public func currentDateUpdated(date: CVDate) {
        if let date = date.convertedDate() {
            let component : BCDateComponent = TimeUtil.getDateComponent(date)
            yearLabel?.text = String(component.year)
            monthLabel?.text = String(component.month) + "月"
        }
    }
    public func didShowNextMonthView(date: NSDate) {
        
    }
    public func didShowPreviousMonthView(date: NSDate) {
        
    }
}
