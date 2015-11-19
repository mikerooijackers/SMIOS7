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
    let date = ["14 oktober 2015  50%|50%",
                "15 oktober 2015  60%|40%",
                "16 oktober 2015  30%|70%",
                "17 oktober 2015  50%|50%",
                "18 oktober 2015  60%|40%",
                "19 oktober 2015  30%|70%"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        Alamofire.request(.GET, "http://smios.mikerooijackers.nl/serviceselect.php")
            .responseJSON { response in
            if let JSON = response.result.value {
                for var i = 0; i < JSON.count; i++ {
                    let startTime = JSON[i]["startTimeDate"]
                    let endTime = JSON[i]["endTimeDate"]
                    print(startTime)
                    print(endTime)
                }
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return date.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = date[row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        print(date[row])
    }
    
}
