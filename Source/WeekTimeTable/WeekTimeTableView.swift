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
    public var calendarView : CalendarView?
    public var collectionView : WeekTimeCollectionView?
    public var yearLabel : UILabel?
    public var monthLabel : UILabel?
    
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
                    let weekDay = (TimeUtil.getDateComponent(event.startDate).weekDay + 5) % 7
                    tempEvents[weekDay].append(event)
                    
                }
                collectionView?.events = tempEvents
            }
            
            
        }
    }
    
    public init(frame: CGRect, appearance: CalendarViewAppearance = CalendarViewAppearance()) {
        super.init(frame: frame)
        calendarView = CalendarView(frame: CGRectMake(40, 0, frame.width-40, CalendarView.viewHeight), appearance: appearance)
        calendarView?.calendarDelegate = self
        addSubview(calendarView!)
        
        let compoent : BCDateComponent = TimeUtil.getDateComponent(NSDate())
        
        yearLabel = UILabel(frame: CGRectMake(0, 0, 40, 24))
        yearLabel?.textAlignment = .Center
        yearLabel?.textColor = UIColor.darkGrayColor()
        yearLabel?.font = UIFont.systemFontOfSize(12)
        yearLabel?.text = String(compoent.year)
        addSubview(yearLabel!)
        
        monthLabel = UILabel(frame: CGRectMake(0, 24, 40, 36))
        monthLabel?.textAlignment = .Center
        monthLabel?.textColor = appearance.weekDaySelectedBgColor
        monthLabel?.font = UIFont.systemFontOfSize(16)
        monthLabel?.text = String(compoent.month) + "月"
        addSubview(monthLabel!)
        
        collectionView = WeekTimeCollectionView(frame: CGRectMake(0, CalendarView.viewHeight, frame.width, frame.height - CalendarView.viewHeight))
        
        
        
        addSubview(collectionView!)
    
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        calendarView?.commonInit()
        collectionView?.scrollToCurrentTime()
    }
    
    
}


extension WeekTimeTableView : CalendarViewDelegate {
    public func didSelectDayView(dayView: DayView, animationDidFinish: Bool) {
        let start = TimeUtil.getWeekStartDate(dayView.date.convertedDate() ?? NSDate())
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
