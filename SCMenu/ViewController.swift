//
//  ViewController.swift
//  SCMenu
//
//  Created by Kalynn Kosyka on 10/6/17.
//  Copyright © 2017 kkosyka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var dateNum: UILabel!
    var mineSpillere = ["Spiller 1", "Spiller 2", "Spiller 3"]
    var first = 0;
    var menu = [[[String]]]()
    var currHouses = [String]()
    var houseMealOptions = [[String]]()
    var currHour = Int()
    var currMin = Int()
    var currMonth = String()
    var currDateNum = String()
    var currDayName = String()
    var currHousesIndex = [String : Int]()//current houses providng meals with corresponding index
    var currHouseSelected = String()
    var currBreakfast = [String]()
    var currLunch = [String]()
    var currDinner = [String]()
    
    func getCurrDateTime(){
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Weekday, .Hour, .Minute, .Second], fromDate: date)
        currHour = components.hour
        currMin = components.minute
        let format = NSDateFormatter()
        format.dateFormat = "MMM"
        currMonth = format.stringFromDate(date)
        format.dateFormat = "dd"
        currDateNum = format.stringFromDate(date)
        format.dateFormat = "E"
        currDayName = format.stringFromDate(date)
    }
    
    func getMenu() {//extract menu from house by webscraping smith college menu php
        enum CustomErrors : String, ErrorType {
            case InvalidURL = "Invalid URL"
        }
        do {
            let str = "https://www.smith.edu/diningservices/menu_poc/cbord_menus.php"
            guard let url = NSURL(string: str) else { throw CustomErrors.InvalidURL }
            let html = try String(contentsOfURL: url)
            let houses = ["Chapin", "Chase/Duckett", "Compstock/Wilder", "Cushing/Emerson", "Cutter/Ziskind", "Ziskind Kosher", "Hubbard", "King/Scales", "Lamont", "Wilson", "Northrop/Gillett", "Tyler"]
            let meals = ["breakfast", "lunch", "dinner"]
            let constantSplit = ["START CHAPIN BLOCK", "START CHASE  BLOCK", "START COMSTOCK  BLOCK", "START CUSHING BLOCK", "START CUTTER Z BLOCK", "START ZISKIND KOSHER  BLOCK", "HUBBARD BLOCK", "START KING HOUSE BLOCK", "START LAMONT BLOCK", "START MORROW/WILSON  BLOCK", "START GILLETT BLOCK", "START TYLER HOUSE BLOCK"]
            var htmlSplitters = [String]()
            var currIndex = 0;
            for (index, house) in houses.enumerate() {
                if html.rangeOfString("<div class=\"col-md-12\"><div class=\"smith-menu-head\"><h2><span>"+house+"</span></h2></div></div>") != nil{
                    currHouses.append(house)
                    currHousesIndex[house] = currIndex++
                    htmlSplitters.append("<div class=\"col-md-12\"><div class=\"smith-menu-head\"><h2><span>"+house+"</span></h2></div></div>")
                }
            }
            let temp = html.componentsSeparatedByStrings(htmlSplitters)
            for (index, house) in currHouses.enumerate() {
                var availableMeals = [String]()
                for (indexMeal, meal) in meals.enumerate() {
                    
                    if temp[index+1].rangeOfString("<div class=\"smith-meal-head smith-" + meal + "\">") != nil{
                        availableMeals.append(meal.uppercaseString)
                    }
                }
                houseMealOptions.append(availableMeals)
            }
            
            var availableSplitter = [String]()
            for (index, constant) in constantSplit.enumerate(){
                if html.rangeOfString("<!-- " + constant + " -->") != nil{
                    availableSplitter.append("<!-- " + constant + " -->")
                }
            }
            let temp1 = html.componentsSeparatedByStrings(availableSplitter)
            var associatedIndex = [Int]() //index match w currHouse in splitHTML
            for (index, house) in temp1.enumerate() {
                for (indexSplit, curr) in currHouses.enumerate(){
                    if house.rangeOfString(curr) != nil{
                        associatedIndex.append(index)
                    }
                }
            }
            for(indexHouse, house) in currHouses.enumerate(){
                let mealHouse = temp1[associatedIndex[indexHouse+4]]

                let temp3 = mealHouse.componentsSeparatedByStrings(houseMealOptions[indexHouse])
                var meal = [[String]]()
                for i in (1...(temp3.count-1)){
                    let temp4 = temp3[i].componentsSeparatedByStrings(["</h4></div><table><tr><td>", "</td></tr><tr><td>", "</td></tr></table></div></div>"])
                    var items = [String]()
                    for j in 0...(temp4.count-2){
                        items.append(temp4[j])
                    }
                    meal.append(items)
                }
                menu.append(meal)
            }
        } catch {
            print(error)
        }
    }
    

    @IBAction func chapin(sender: AnyObject) {
        goToMenuHouse("Chapin")
    }
    @IBAction func chaseDuckett(sender: AnyObject) {
        goToMenuHouse("Chase/Duckett")
    }
    @IBAction func comstockWilder(sender: AnyObject) {
        goToMenuHouse("Compstock/Wilder")
    }
    
    @IBAction func cushingEmerson(sender: AnyObject) {
        goToMenuHouse("Cushing/Emerson")
    }
    @IBAction func cutterZ(sender: AnyObject) {
        goToMenuHouse("Cutter/Ziskind")
    }
        
    @IBAction func ziskindKosher(sender: AnyObject) {
        goToMenuHouse("Ziskind Kosher")
    }
    
    @IBAction func hubbard(sender: AnyObject) {
        goToMenuHouse("Hubbard")
    }
    
    @IBAction func kingScales(sender: AnyObject) {
        goToMenuHouse("King/Scales")
    }
    @IBAction func lamont(sender: AnyObject) {
        goToMenuHouse("Lamont")
    }
    
    @IBAction func wilson(sender: AnyObject) {
        goToMenuHouse("Wilson")
    }
    @IBAction func northropGillett(sender: AnyObject) {
        goToMenuHouse("Northrop/Gillett")
    }
    
    @IBAction func tyler(sender: AnyObject) {
        goToMenuHouse("Tyler")
    }
    
    func goToMenuHouse(house: String){
        currHouseSelected = house
        var corrIndex = -1
        if let val = currHousesIndex[house] {
            corrIndex = val
        }
        let mealViews = ["breakfastView", "lunchView", "dinnerView"]
        var vcName = String()
        //weekday
        if(currDayName == "Mon" || currDayName == "Tue" || currDayName == "Wed" || currDayName == "Thu" || currDayName == "Fri"){
            if(currHour >= 0 && currHour < 10){vcName = mealViews[0]}//breakfast
            if(currHour >= 10 && currHour < 14){vcName = mealViews[1]}//lunch
            if(currHour >= 14 && currHour <= 23){vcName = mealViews[2]}//dinner
        }else{//weekend
            if(currHour >= 0 && currHour < 14){vcName = mealViews[1] }//brunch
            if(currHour >= 14 && currHour <= 23){vcName = mealViews[2] }//dinner
        }

        if(corrIndex != -1){//currHouse selected serving food
            var currMenuHouse = menu[corrIndex]
            for (index, item) in (houseMealOptions[corrIndex].enumerate()){
                if(item == "BREAKFAST"){currBreakfast = currMenuHouse[index]}
                if(item == "LUNCH"){currLunch = currMenuHouse[index]}
                if(item == "DINNER"){currDinner = currMenuHouse[index]}
            }
        }
        
        if(vcName == "breakfastView"){
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier(vcName) as! DinnerViewController
            vc.breakfast = currBreakfast
            vc.lunch = currLunch
            vc.dinner = currDinner
            vc.currHouse = currHouseSelected
            self.presentViewController(vc, animated: true, completion: nil)
        }
        if(vcName == "lunchView"){
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier(vcName) as! LunchViewController
            vc.breakfast = currBreakfast
            vc.lunch = currLunch
            vc.dinner = currDinner
            vc.currHouse = currHouseSelected
            self.presentViewController(vc, animated: true, completion: nil)
        }
        if(vcName == "dinnerView"){
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier(vcName) as! DinnerViewController
            vc.breakfast = currBreakfast
            vc.lunch = currLunch
            vc.dinner = currDinner
            vc.currHouse = currHouseSelected
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        getCurrDateTime()
        super.viewDidLoad()
        month.text = String(currMonth)
        dateNum.text = String(currDateNum)
        getMenu()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showHoursPopup(sender: AnyObject) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("hoursPopUp") as! PopUpViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)
    }
    
    
    
}

extension String {
    func componentsSeparatedByStrings(separators: [String]) -> [String] {
        return separators.reduce([self]) { result, separator in
            return result.flatMap { $0.componentsSeparatedByString(separator) }
            }
            .map { $0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) }
    }
}






//    @IBAction func changeDatePopUp(sender: AnyObject) {
//        self.viewDidLoad();
//
//        self.addChildViewController(changeDateDisplay)
//        changeDateDisplay.view.frame = self.view.frame
//        self.view.addSubview(changeDateDisplay.view)
//        changeDateDisplay.didMoveToParentViewController(self)
//    }




