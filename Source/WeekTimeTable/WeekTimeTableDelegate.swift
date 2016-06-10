//
//  WeekTimeTableDelegate.swift
//  BocaiConsultant
//
//  Created by Sebarina Xu on 6/7/16.
//  Copyright © 2016 liufan. All rights reserved.
//

import Foundation


@objc public protocol WeekTimeTableDelegate {
    optional func weekTimeTableAddEvent(starTime: NSDate, endTime: NSDate) -> Void
    optional func weekTimeTableDidSelectEvent(event: AnyObject?) -> Void
    optional func weekTimeWeekTimeUpdated(starTime: NSDate) -> Void
}