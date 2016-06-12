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
    public var menuView : CVCalendarMenuView?
    public var calendarView : CVCalendarView?
    public var animationFinished : Bool = true
    private let menuHeight : CGFloat = 24
    private let calendarRowHeight : CGFloat = 36
    public static var viewHeight : CGFloat = 65

    public weak var calendarDelegate : BCCalendarViewDelegate?
    
    
    public var startTime : NSDate {
        return (calendarView?.contentController as? WeekContentViewController)?.getPresentedWeek()?.dayViews.first?.date.convertedDate() ?? NSDate()
    }
    
    public var endTime : NSDate {
        return (calendarView?.contentController as? WeekContentViewController)?.getPresentedWeek()?.dayViews.last?.date.convertedDate() ?? NSDate()
    }
    
    public init(frame: CGRect, appearance: BCCalendarViewAppearance = BCCalendarViewAppearance()) {
        super.init(frame: frame)
        self.appearance = appearance
        menuView = CVCalendarMenuView(frame: CGRectMake(0, 0, frame.width, menuHeight))
        addSubview(menuView!)
    
        calendarView = CVCalendarView(frame: CGRectMake(0, menuHeight, frame.width, calendarRowHeight))
        addSubview(calendarView!)
        
        menuView?.menuViewDelegate = self
        calendarView?.calendarDelegate = self
        calendarView?.calendarAppearanceDelegate = self
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func commonInit() {
        calendarView?.commitCalendarViewUpdate()
        menuView?.commitMenuViewUpdate()
        
    }
    
    public var currentMode : CalendarMode {
        return calendarView?.calendarMode ?? .WeekView
    }
    
    public func changeMode(mode: CalendarMode) {
        calendarView?.changeMode(mode)
        if mode == .WeekView {
            calendarView?.frame.size.height = (calendarView?.contentController.bounds.height) ?? calendarRowHeight
            self.frame.size.height = ((calendarView?.contentController.bounds.height) ?? calendarRowHeight) + menuHeight + 10
        } else {
            calendarView?.frame.size.height = (calendarView?.contentController.bounds.height) ?? calendarRowHeight*5
            self.frame.size.height = ((calendarView?.contentController.bounds.height) ?? calendarRowHeight*5) + menuHeight + 10
        }
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

