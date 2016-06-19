//
//  ViewController1.swift
//  BCTimeTableDemo
//
//  Created by Sebarina Xu on 6/15/16.
//  Copyright © 2016 bocai. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
