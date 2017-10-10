//
//  PopUpViewController.swift
//  SCMenu
//
//  Created by Kalynn Kosyka on 10/6/17.
//  Copyright © 2017 kkosyka. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
//    @IBOutlet weak var datePicked: UIDatePicker!
//    let currDate = NSDate()
//    var month = String()
//    var dateNum = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.85)

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopup(sender: AnyObject) {
        self.view.removeFromSuperview()
    }
//    func getCurrDate(){
//        let date = NSDate()
//        let monthFormat = NSDateFormatter()
//        monthFormat.dateFormat = "MMM"
//        month = monthFormat.stringFromDate(date)
//        
//        let dayFormat = NSDateFormatter()
//        dayFormat.dateFormat = "dd"
//        dateNum = dayFormat.stringFromDate(date)
//        return
//
//    }
//    
//    @IBAction func closePopUp(sender: AnyObject) {
//        self.view.removeFromSuperview()
//    }
//    
//    @IBAction func submitChange(sender: AnyObject) {
//        self.view.removeFromSuperview()
//        datePicked.datePickerMode = UIDatePickerMode.Date
//        let dayNumFormatter  = NSDateFormatter()
//        dayNumFormatter.dateFormat = "dd"
//        dateNum = dayNumFormatter.stringFromDate(datePicked.date)
//        let monthFormatter  = NSDateFormatter()
//        monthFormatter.dateFormat = "MMM"
//        month = monthFormatter.stringFromDate(datePicked.date)
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
