//
//  ViewController2.swift
//  BCTimeTableDemo
//
//  Created by Sebarina Xu on 6/15/16.
//  Copyright © 2016 bocai. All rights reserved.
//

import UIKit
import BCWeekTimeTable
import CVCalendar

class ViewController2: UIViewController {

    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarView: BCCalendarView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        calendarView.commonInit()
//    }
    
    
    @IBAction func changeMode(sender: AnyObject) {
        if calendarView.currentMode == .WeekView {
            calendarView.changeMode(.MonthView)
        } else {
            calendarView.changeMode(.WeekView)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
