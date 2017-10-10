//
//  BreakfastViewController.swift
//  SCMenu
//
//  Created by Kalynn Kosyka on 10/9/17.
//  Copyright © 2017 kkosyka. All rights reserved.
//

import UIKit

class BreakfastViewController: UIViewController {
    @IBOutlet weak var houseName: UILabel!

    var breakfast = [String]()
    var lunch = [String]()
    var dinner = [String]()
    var currHouse = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        houseName.text = currHouse
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showLunch(sender: AnyObject) {
        let vc = storyboard!.instantiateViewControllerWithIdentifier("lunchView") as! LunchViewController
        vc.breakfast = breakfast
        vc.lunch = lunch
        vc.dinner = dinner
        vc.currHouse = currHouse
        presentViewController(vc, animated: true, completion: nil)
    
    }
    
    @IBAction func showDinner(sender: AnyObject) {
        let vc = storyboard!.instantiateViewControllerWithIdentifier("dinnerView") as! DinnerViewController
        vc.breakfast = breakfast
        vc.lunch = lunch
        vc.dinner = dinner
        vc.currHouse = currHouse
        presentViewController(vc, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell()
        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.lineBreakMode = .ByWordWrapping
        var item = breakfast[indexPath.row]
        if(breakfast[indexPath.row].containsString("</td></tr>")){
            let temp = breakfast[indexPath.row].componentsSeparatedByString("</td></tr>")
            item = temp[0]
        }
        cell.textLabel?.text = item
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breakfast.count
    }

}
