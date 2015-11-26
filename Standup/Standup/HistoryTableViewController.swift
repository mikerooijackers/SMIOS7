//
//  HistoryTableViewController.swift
//  Standup
//
//  Created by Mike Rooijackers on 02-11-15.
//  Copyright © 2015 SMIOS7 Healthkit. All rights reserved.
//

import UIKit
import Alamofire

class HistoryTableViewController: UITableViewController{
    @IBOutlet var historyTableView: UITableView!
    
    let textCellIdentifier = "textCell"
    var activitieCollections : [ActivityCollection] = [ActivityCollection]()
    var valueToPass : ActivityCollection?
    
    
    /*let date = ["14 oktober 2015  50%|50%",
                "15 oktober 2015  60%|40%",
                "16 oktober 2015  30%|70%",
                "17 oktober 2015  50%|50%",
                "18 oktober 2015  60%|40%",
                "19 oktober 2015  30%|70%"]*/
    
    
    func convertStringToDate(datestring stringvalue : String) -> NSDate{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormats.full.rawValue
        let date = dateFormatter.dateFromString(stringvalue)
        
        return date!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        Alamofire.request(.GET, "http://smios.mikerooijackers.nl/serviceselect.php")
            .responseJSON { response in
            if let JSON = response.result.value {
                
                let activities = ActivityCollection()
                for var i = 0; i < JSON.count; i++ {
                    let startTime = JSON[i]["startTimeDate"] as! String
                    let endTime = JSON[i]["endTimeDate"] as! String
                    print(startTime)
                    print(endTime)
                    let startDate = self.convertStringToDate(datestring: startTime)
                    let endDate = self.convertStringToDate(datestring: endTime)
                    let activity = Activity(startDate: startDate, endDate: endDate, type: Activity.ActivityType.active)
                    activities.addActivity(activity)
                }
                self.activitieCollections.removeAll()
                self.activitieCollections.append(activities)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.historyTableView.reloadData()
                })
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activitieCollections.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        let row = indexPath.row
        let activevalue = activitieCollections[row].getPercentage(Activity.ActivityType.active)
        let inactivevalue = activitieCollections[row].getPercentage(Activity.ActivityType.inactive)
        let simpledate = activitieCollections[row].dateWithFormat(dateformat: dateFormats.simple)
        cell.textLabel?.text = ("\(simpledate) :  \(activevalue) % Active, \(inactivevalue) % Inactive")
        
        return cell
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        valueToPass = activitieCollections[0]
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "historySegue") {
            
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destinationViewController as! HistoryDetailViewController
            // your new view controller should have property that will store passed value
            valueToPass = activitieCollections[0]
            viewController.passedValue = valueToPass
        }
        
    }
    
}
