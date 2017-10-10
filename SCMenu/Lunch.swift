//
//  Lunch.swift
//  SCMenu
//
//  Created by Kalynn Kosyka on 10/8/17.
//  Copyright © 2017 kkosyka. All rights reserved.
//

import UIKit


class Lunch: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var lunchTable: UITableView!
    let lunch = ["food", "more food", "foooooooood", "yes food", "i am hungry"]
    override func viewDidLoad() {
        super.viewDidLoad()
        lunchTable.dataSource = self
        lunchTable.delegate = self
        lunchTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "lunchView")
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lunch.count

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("lunchView", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = lunch[indexPath.item]
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        lunchTable.reloadData()
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
