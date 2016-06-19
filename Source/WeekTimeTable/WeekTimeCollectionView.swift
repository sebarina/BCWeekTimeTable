//
//  ScheduleView.swift
//  BocaiConsultant
//
//  Created by Sebarina Xu on 6/7/16.
//  Copyright © 2016 liufan. All rights reserved.
//

import UIKit

public class WeekTimeCollectionView: UICollectionView {
    
    private var appearance = WeekTimeAppearance()
    
    private var cellWidth : CGFloat = 0
    private var cellHeight : CGFloat = 80
    private let footerHeight : CGFloat = 30
    private var eventButtons : [EventButton] = []
    private var _addButton : UIButton?
    private let addButtonTag : Int = 10009
    private var timeWidth : CGFloat = 40
    public var firstWeekDay : Int = 1
    
    public var startDate : NSDate!
    
    public weak var appearanceDelegate : WeekTimeAppearanceDelegate? {
        didSet {
            if appearanceDelegate != nil {
                appearance.timeColor ~> appearanceDelegate!.weekTimeTableTimeColor?() 
                appearance.eventTitleColor ~> appearanceDelegate!.weekTimeTableEventTitleColor?()
                appearance.lineColor ~> appearanceDelegate!.weekTimeTableLineColor?()
                appearance.dashLineColor ~> appearanceDelegate!.weekTimeTableDashlineColor?()
                appearance.addButtonBgColor ~> appearanceDelegate!.weekTimeAddButtonBgColor?()
                appearance.addButtonImage ~> appearanceDelegate!.weekTimeAddButtonImage?()
                appearance.addButtonText ~> appearanceDelegate!.weekTimeAddButtonTitle?()
                appearance.startHour ~> appearanceDelegate!.weekTimeTableStartHour?()
                appearance.endHour ~> appearanceDelegate!.weekTimeTableEndHour?()
            }
        }
    }
    
    public weak var weekTimeDelegate : WeekTimeTableDelegate?

    public init(frame: CGRect, timeWidth : CGFloat, firstWeekDay: Int = 1) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        super.init(frame: frame, collectionViewLayout: layout)
        self.timeWidth = timeWidth
        self.firstWeekDay = firstWeekDay
        startDate = TimeUtil.getWeekStartDate(NSDate(), firstWeekDay: firstWeekDay)
        cellWidth = CGFloat(Int((frame.width - timeWidth)/7))
        cellHeight = cellWidth*4/3
        self.timeWidth = frame.width - cellWidth*7
        backgroundColor = UIColor.whiteColor()
        dataSource = self
        delegate = self
        registerClass(WeekTimeCell.self, forCellWithReuseIdentifier: WeekTimeCell.reuseIdentifier)
        registerClass(TimeTitleCell.self, forCellWithReuseIdentifier: TimeTitleCell.reuseIdentifier)
        registerClass(WeekTimeFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: WeekTimeFooterView.reuseIdentifier)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(WeekTimeCollectionView.handleTapGesture(_:))))
        
        
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

//    public var startTime : NSDate 
    

    public var events : [[WeekScheduleEvent]]? {
        didSet {
            if events != nil {
                // 获取每天的group events
                for button in eventButtons {
                    button.removeFromSuperview()
                }
                eventButtons.removeAll()
                for day in 0 ..< events!.count {
                    let data = events![day]
                    var groups: [[WeekScheduleEvent]] = []
                    var group = [WeekScheduleEvent]()
                    var startTime : Double = 0
                    var endTime : Double = 0
                    for i in 0 ..< data.count {
                        if data[i].startSeconds < Double(appearance.startHour * 3600) || data[i].endSeconds > Double(appearance.endHour*3600) {
                            continue
                        }
                        if i == 0 {
                           
                            startTime = data[0].startSeconds
                            endTime = data[0].endSeconds
                            group.append(data[0])
                        } else {
                            if data[i].endSeconds <= startTime || data[i].startSeconds >= endTime {
                                // create new group
                                groups.append(group)
                                group.removeAll()
                                group.append(data[i])
                                startTime = data[i].startSeconds
                                endTime = data[i].endSeconds
                            } else {
                                group.append(data[i])
                                startTime = min(startTime, data[i].startSeconds)
                                endTime = max(endTime, data[i].endSeconds)
                                
                            }
                        }
                    }
                    groups.append(group)
                    
                    for group in groups {
                        let eventWidth : CGFloat = (cellWidth-2)/CGFloat(group.count)
                        for index in 0 ..< group.count {
                            let event = group[index]
                            drawEvent(event, width: eventWidth, index: index, day: day)
                        }
                    }
                    
                    scrollToCurrentTime()
                }
                
            }
        }
    }
    
    func drawEvent(event: WeekScheduleEvent, width: CGFloat, index: Int, day: Int) {
        let x : CGFloat = timeWidth + cellWidth*CGFloat(day) + CGFloat(index)*width
        let y : CGFloat = cellHeight/3600.0*CGFloat(event.startSeconds - Double(appearance.startHour*3600)) + 7
        let h : CGFloat = cellHeight/3600.0*CGFloat(event.endSeconds - event.startSeconds)
        let button = EventButton(frame: CGRectMake(x,y,width,h))
        button.backgroundColor = event.eventColor
        button.setTitle(event.eventTitle, forState: .Normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.font = UIFont.systemFontOfSize(10)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.customEvent = event.customValue
        button.addTarget(self, action: #selector(WeekTimeCollectionView.eventClicked(_:)), forControlEvents: .TouchUpInside)
        eventButtons.append(button)
        addSubview(button)
    }
    
    func createAddButton(rect: CGRect) {
        _addButton = UIButton(frame: rect)
        _addButton?.backgroundColor = appearance.addButtonBgColor
        _addButton?.imageView?.contentMode = .ScaleAspectFit
        if appearance.addButtonImage != UIImage() {
            _addButton?.setImage(appearance.addButtonImage, forState: .Normal)
        }
        if !appearance.addButtonText.isEmpty {
            _addButton?.setTitle(appearance.addButtonText, forState: .Normal)
        }
        
        _addButton?.addTarget(self, action: #selector(WeekTimeCollectionView.addButtonAction), forControlEvents: .TouchUpInside)
    }
    
    public func scrollToCurrentTime() {

        let hour = TimeUtil.getDateComponent(NSDate()).hour - appearance.startHour
        scrollRectToVisible(CGRectMake(0, CGFloat(hour)*cellHeight + 8, frame.width, cellHeight), animated: false)
        
        
    }
    
    func eventClicked(sender: EventButton) {
        weekTimeDelegate?.weekTimeTableDidSelectEvent?(sender.customEvent)
    }
}

extension WeekTimeCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8*(appearance.endHour - appearance.startHour)
    }
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.row % 8 == 0 {
            return CGSize(width: timeWidth, height: cellHeight)
        } else {
            return CGSize(width: cellWidth, height: cellHeight)
        }
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.row % 8 == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(TimeTitleCell.reuseIdentifier, forIndexPath: indexPath) as! TimeTitleCell
            cell.titleColor = appearance.timeColor
            cell.time = String(indexPath.row/8 + appearance.startHour)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(WeekTimeCell.reuseIdentifier, forIndexPath: indexPath) as! WeekTimeCell
            cell.dashLineColor = appearance.dashLineColor
            cell.lineColor = appearance.lineColor
            cell.setNeedsDisplay()
            return cell
        }
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: footerHeight)
    }
    
    public func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: WeekTimeFooterView.reuseIdentifier, forIndexPath: indexPath) as! WeekTimeFooterView
        view.lineColor = appearance.lineColor
        view.titleColor = appearance.timeColor
        view.titleWidth = timeWidth
        view.hour = String(appearance.endHour)
        return view
    }
    
    
}

extension WeekTimeCollectionView {
    func handleTapGesture(gesture: UITapGestureRecognizer) {
        let position = gesture.locationInView(self)
        
        if position.x <= timeWidth || position.y <= 8 {
            return
        }
        let xIndex = Int((position.x - timeWidth)/cellWidth)
        let yIndex = Int((position.y - 8)/cellHeight)
        
        let yOffset = position.y - 8 - CGFloat(yIndex)*cellHeight
        let x = timeWidth + CGFloat(xIndex)*cellWidth
        var y = CGFloat(yIndex)*cellHeight + 8
        if yOffset > cellHeight/2{
            y += cellHeight/2
        }
        
        if _addButton == nil {
            createAddButton(CGRectMake(x, y, cellWidth, cellHeight/2))
        
        } else {
            _addButton?.removeFromSuperview()
            _addButton?.frame = CGRectMake(x, y, cellWidth, cellHeight/2)
            
        }
    
        addSubview(_addButton!)
        
    }
    
    func addButtonAction(sender: UIButton) {
        _addButton?.removeFromSuperview()
        let rect = sender.frame
        let col = Int((rect.origin.x - timeWidth + 1)/cellWidth)
        let row = Int((rect.origin.y - 7)/cellHeight)
        let offset = rect.origin.y - 7 - CGFloat(row)*cellHeight
        
        let start = startDate.dateByAddingTimeInterval(Double(col*24*3600 + row*3600 + (offset >= cellHeight/2 ? 1800 : 0) + appearance.startHour*3600))
        
        let end = start.dateByAddingTimeInterval(Double(1800))
        
        
        weekTimeDelegate?.weekTimeTableAddEvent?(start, endTime: end, addButton: sender)
        
    }
}
