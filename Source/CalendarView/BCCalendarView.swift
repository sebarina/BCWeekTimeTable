//
//  CalendarView.swift
//  BocaiConsultant
//
//  Created by Sebarina Xu on 6/6/16.
//  Copyright © 2016 liufan. All rights reserved.
//

import UIKit
import CVCalendar

public class BCCalendarView: UIView {
    public var appearance = BCCalendarViewAppearance()
    
    public var menuView: CVCalendarMenuView?

    public var calendarView: CVCalendarView?
    public var calendarHeightContraint : NSLayoutConstraint?
    
    public static var viewHeight : CGFloat = 68

    public weak var calendarDelegate : BCCalendarViewDelegate?
    
    
    public var startTime : NSDate {
        return (calendarView?.contentController as? WeekContentViewController)?.getPresentedWeek()?.dayViews.first?.date.convertedDate() ?? NSDate()
    }
    
    public var endTime : NSDate {
        return (calendarView?.contentController as? WeekContentViewController)?.getPresentedWeek()?.dayViews.last?.date.convertedDate() ?? NSDate()
    }
    
    
    public init(frame: CGRect, appearance: BCCalendarViewAppearance = BCCalendarViewAppearance()) {
        super.init(frame: frame)
        setup()
        self.appearance = appearance
        menuView?.menuViewDelegate = self
        calendarView?.calendarDelegate = self
        calendarView?.calendarAppearanceDelegate = self
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        menuView?.menuViewDelegate = self
        calendarView?.calendarDelegate = self
        calendarView?.calendarAppearanceDelegate = self
    }
    
    func setup() {
        menuView = CVCalendarMenuView()
        addSubview(menuView!)
        menuView!.translatesAutoresizingMaskIntoConstraints = false
        
        let ml = NSLayoutConstraint(item: menuView!, 
                                   attribute: .Leading, 
                                   relatedBy: .Equal, 
                                   toItem: self, 
                                   attribute: .Leading, 
                                   multiplier: 1.0, 
                                   constant: 0)
        let mr = NSLayoutConstraint(item: menuView!, 
                                   attribute: .Trailing, 
                                   relatedBy: .Equal, 
                                   toItem: self, 
                                   attribute: .Trailing, 
                                   multiplier: 1.0, 
                                   constant: 0)
        let mt = NSLayoutConstraint(item: menuView!, 
                                   attribute: .Top, 
                                   relatedBy: .Equal, 
                                   toItem: self, 
                                   attribute: .Top, 
                                   multiplier: 1.0, 
                                   constant: 8)
        let mh = NSLayoutConstraint(item: menuView!, 
                                   attribute: .Height, 
                                   relatedBy: .Equal, 
                                   toItem: nil, 
                                   attribute: .NotAnAttribute, 
                                   multiplier: 1.0, 
                                   constant: 24)
        NSLayoutConstraint.activateConstraints([ml,mr,mt,mh])
        
        calendarView = CVCalendarView()
        addSubview(calendarView!)
        calendarView!.translatesAutoresizingMaskIntoConstraints = false
        let cl = NSLayoutConstraint(item: calendarView!, 
                                    attribute: .Leading, 
                                    relatedBy: .Equal, 
                                    toItem: self, 
                                    attribute: .Leading, 
                                    multiplier: 1.0, 
                                    constant: 0)
        let cr = NSLayoutConstraint(item: calendarView!, 
                                    attribute: .Trailing, 
                                    relatedBy: .Equal, 
                                    toItem: self, 
                                    attribute: .Trailing, 
                                    multiplier: 1.0, 
                                    constant: 0)
        let ct = NSLayoutConstraint(item: calendarView!, 
                                    attribute: .Top, 
                                    relatedBy: .Equal, 
                                    toItem: menuView!, 
                                    attribute: .Bottom, 
                                    multiplier: 1.0, 
                                    constant: 0)
        calendarHeightContraint = NSLayoutConstraint(item: calendarView!, 
                                    attribute: .Height, 
                                    relatedBy: .Equal, 
                                    toItem: nil, 
                                    attribute: NSLayoutAttribute.NotAnAttribute, 
                                    multiplier: 1.0, 
                                    constant: 36)
        
        NSLayoutConstraint.activateConstraints([cl, cr, ct, calendarHeightContraint!])
        
        clipsToBounds = true
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        commonInit()
    }
    
    public func commonInit() {
        calendarView?.commitCalendarViewUpdate()
        menuView?.commitMenuViewUpdate()
        
    }
    
    public var currentMode : CalendarMode {
        return calendarView?.calendarMode ?? .WeekView
    }
    
    public var currentHeight : CGFloat {
        return (calendarView?.contentController.bounds.height ?? 0) + 32
    }
    
    public func changeMode(mode: CalendarMode) {
        calendarView?.changeMode(mode)
        calendarHeightContraint?.constant = calendarView!.contentController.bounds.height
    }

}

extension BCCalendarView : CVCalendarViewAppearanceDelegate {
    public func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
    
    public func spaceBetweenDayViews() -> CGFloat {
        return appearance.spaceBetweenDays
    }
    
    public func spaceBetweenWeekViews() -> CGFloat {
        return appearance.spaceBetweenDays
    }
    
    public func dayLabelPresentWeekdaySelectedBackgroundColor() -> UIColor {
        return appearance.currentDaySelectedBgColor
    }
    
    public func dayLabelPresentWeekdaySelectedTextColor() -> UIColor {
        return appearance.currentDaySelectedTextColor
    }
    
    public func dayLabelPresentWeekdayTextColor() -> UIColor {
        return appearance.currentDayTextColor
    }
    
    public func dayLabelWeekdayInTextColor() -> UIColor {
        return appearance.weekDayInTextColor
    }
    
    public func dayLabelWeekdayOutTextColor() -> UIColor {
        return appearance.weekDayOutTextColor
    }
    
    public func dayLabelWeekdaySelectedTextColor() -> UIColor {
        return appearance.weekDaySelectedTextColor
    }
    
    public func dayLabelWeekdaySelectedBackgroundColor() -> UIColor {
        return appearance.weekDaySelectedBgColor
    }
    
    public func dayLabelWeekdayTextSize() -> CGFloat {
        return appearance.weekDayTextSize
    }
    
    public func dayLabelPresentWeekdayTextSize() -> CGFloat {
        return appearance.currentDayTextSize
    }
    
}

extension BCCalendarView : CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    public func firstWeekday() -> Weekday {
        return appearance.firstDay
    }
    
    public func weekdaySymbolType() -> WeekdaySymbolType {
        return appearance.weekdaySymbolType
    }
    
    public func presentationMode() -> CalendarMode {
        return .WeekView
    }
    
    public func shouldAutoSelectDayOnWeekChange() -> Bool {
        return true
    }
    
    public func shouldAutoSelectDayOnMonthChange() -> Bool {
        return true
    }
    
    public func shouldShowWeekdaysOut() -> Bool {
        return true
    }
    
    public func shouldAnimateResizing() -> Bool {
        return true
    }
    
    public func didSelectDayView(dayView: DayView, animationDidFinish: Bool) {
        calendarDelegate?.didSelectDayView?(dayView, animationDidFinish: animationDidFinish)
    }
    
    
    
    public func presentedDateUpdated(date: CVDate) {
        calendarDelegate?.currentDateUpdated?(date)
        
    }
    
    
    public func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return false
    }
    
    
    public func didShowNextMonthView(date: NSDate) {
        calendarDelegate?.didShowNextMonthView?(date)
    }
    
    public func didShowPreviousMonthView(date: NSDate) {
        calendarDelegate?.didShowPreviousMonthView?(date)
    }
    
    
    public func shouldShowCustomSingleSelection() -> Bool {
        return true
    }
    
    //当日的背景颜色
    public func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.bounds, shape: CVShape.Circle)
        circleView.fillColor = appearance.currentDayBgColor
        return circleView
    }
    
    public func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        if (dayView.isCurrentDay) {
            return true
        }
        return false
    }
    
    
    
}

