//
//  TodayViewController.swift
//  standup
//
//  Created by Fhict on 19/10/15.
//  Copyright © 2015 SMIOS7 Healthkit. All rights reserved.
//

import UIKit;
import Charts;
import HealthKit;
import Alamofire

class TodayViewController : UIViewController{
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    var startDate : NSDate!;
    var endDate : NSDate!;
    let calander : NSCalendar = NSCalendar.currentCalendar()
    let activities = ActivityCollection()
    let dateFormatter = NSDateFormatter()
    let healtkitManager : HealthKitManager = HealthKitManager();
    
    //var facebookID : String;

    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let date = NSDate()
        endDate = NSDate()
        let today = calander.components([.Year, .Month, .Day], fromDate: date)
        today.day = 8
        today.hour = 0
        today.minute = 0
        today.second = 1
        let todayEnd = calander.components([.Year, .Month, .Day], fromDate: date)
        todayEnd.day = 8
        todayEnd.hour = 23;
        todayEnd.minute = 59;
        todayEnd.second = 59;
        startDate = calander.dateFromComponents(today)!
        endDate = calander.dateFromComponents(todayEnd)!
        QueryToday()
    }
    
    @IBOutlet weak var DayBreakDownRectangle: DrawRect!
    
    @IBAction func refreshClick(sender: AnyObject) {
        QueryToday()
        
    }
    
    func QueryToday(){
        healtkitManager.authorizeHealthKit { (success, error) -> Void in
            if success{
                self.activities.clearActivities()
                let hkSampleType:HKSampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)!
                // Create a predicate to set start/end date bounds of the query HKQueryOptionStrictStartDate
                let predicate:NSPredicate = HKQuery.predicateForSamplesWithStartDate(self.startDate, endDate: self.endDate, options: HKQueryOptions.StrictEndDate)
                let descriptors = [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)]
                // Create a sort descriptor for sorting by start date
                //let hkSampleType:HKSampleType = HKSampleType.correlationTypeForIdentifier(HKCorrelationTypeIdentifierFood)!
                //let hkSampleType:HKSampleType = HKSampleType.categoryTypeForIdentifier(HKCategoryTypeIdentifierAppleStandHour)!
                
                let query = HKSampleQuery(sampleType: hkSampleType, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: descriptors, resultsHandler: { (query:HKSampleQuery, results:[HKSample]?, error:NSError?) -> Void in
                    print("query executed")
                    print(results!.count)
                    
                    if let samples = results{
                        for sample in samples{
                            self.activities.addActivity(Activity(startDate: sample.startDate, endDate: sample.endDate, type: .active))
                            print("\(sample.startDate.description) \(sample.endDate.description) " )
                        }
                        self.setChart(["Active", "Inactive"], values: self.activities.getActiveAndInactivePercentageAsArray())
                        self.DayBreakDownRectangle.redrawRect(activities: self.activities.activities)
                        
                    }
                })
                
                self.healtkitManager.healthKitStore.executeQuery(query)
            }
        }
    }
    
    func setChart(dataPoints: [String], values: [Int]) {
        
        var colors: [UIColor] = []
        colors.append(UIColor( red: 0, green: 0, blue: 255, alpha: 1))
        colors.append(UIColor( red: 255, green: 0, blue: 0, alpha: 1))
        
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: Double(values[i]), xIndex: i)
            dataEntries.append(dataEntry)
        }
        pieChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "")
        pieChartDataSet.colors = colors

        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        pieChartView.descriptionText = "Overzicht actief / inactief"
        pieChartView.centerText = "Today,  \(dateFormatter.stringFromDate(startDate))"
        
    }
    
    /*func sendData(facebookID:String) {
        print(facebookID)
        Alamofire.request(Alamofire.Method.GET, "http://smios.mikerooijackers.nl/servicequery.php", parameters: ["facebookID": facebookID])
    }*/
}

