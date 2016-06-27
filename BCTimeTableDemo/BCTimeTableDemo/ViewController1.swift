//
//  ViewController1.swift
//  BCTimeTableDemo
//
//  Created by Sebarina Xu on 6/15/16.
//  Copyright © 2016 bocai. All rights reserved.
//

import UIKit
import BCWeekTimeTable
import CVCalendar

class ViewController1: UIViewController {
    var calendarView : BCCalendarView?
    var yearLabel : UIButton?
    var ch : NSLayoutConstraint?
    var testView : UIView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        calendarView = BCCalendarView(frame: CGRectZero, appearance: BCCalendarViewAppearance())
        view.addSubview(calendarView!)
//        calendarView?.calendarDelegate = self
        calendarView?.translatesAutoresizingMaskIntoConstraints = false
        let cl = NSLayoutConstraint(item: calendarView!, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1.0, constant: 40.0)
        let ct = NSLayoutConstraint(item: calendarView!, attribute: .Top, relatedBy: .Equal, toItem: self.topLayoutGuide, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let cw = NSLayoutConstraint(item: calendarView!, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: 0)
        ch = NSLayoutConstraint(item: calendarView!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 68.0)
//        view.addSubview(calendarView!)
        NSLayoutConstraint.activateConstraints([ct, cw, cl, ch!])
        
        
        
        
        yearLabel = UIButton(frame: CGRectMake(0, 72, 40, 24))
        yearLabel?.setTitle("Test", forState: .Normal)
        yearLabel?.setTitleColor(UIColor.blackColor(), forState: .Normal)
        yearLabel?.addTarget(self, action: #selector(self.changeMode), forControlEvents: .TouchUpInside)
//        yearLabel?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(yearLabel!)
//        
//        let yl = NSLayoutConstraint(item: yearLabel!, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1.0, constant: 0)
//        let yt = NSLayoutConstraint(item: yearLabel!, attribute: .Top, relatedBy: .Equal, toItem: self.topLayoutGuide, attribute: .Bottom, multiplier: 1.0, constant: 8)
//        let yw = NSLayoutConstraint(item: yearLabel!, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 40)
//        let yh = NSLayoutConstraint(item: yearLabel!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 24)
//        NSLayoutConstraint.activateConstraints([yl, yt, yw, yh])
        testView = UIView()
        view.addSubview(testView!)
        testView?.translatesAutoresizingMaskIntoConstraints = false
        
        let l = NSLayoutConstraint(item: testView!, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1.0, constant: 0)
        let r = NSLayoutConstraint(item: testView!, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .Trailing, multiplier: 1.0, constant: 0)
        let t = NSLayoutConstraint(item: testView!, attribute: .Top, relatedBy: .Equal, toItem: calendarView!, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let b = NSLayoutConstraint(item: testView!, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0)
        NSLayoutConstraint.activateConstraints([l, r, t, b])
        testView?.backgroundColor = UIColor.blueColor()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.enabled = true
        self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        let tempView = UIButton(frame: CGRectMake(0,0,52,22))
        tempView.setTitle("< custom", forState: .Normal)
        tempView.setTitleColor(UIColor.brownColor(), forState: .Normal)
        tempView.addTarget(self, action: #selector(self.back), forControlEvents: .TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: tempView)
    }
    
    func back() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func changeMode() {
        if calendarView!.currentMode == .WeekView {
            calendarView?.changeMode(.MonthView)
        } else {
            calendarView?.changeMode(.WeekView)
        }
        ch?.constant = calendarView!.currentHeight
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        calendarView?.commonInit()
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
