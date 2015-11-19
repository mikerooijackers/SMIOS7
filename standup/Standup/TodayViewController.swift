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

class TodayViewController : UIViewController{
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    var startDate : NSDate!;
    var endDate : NSDate!;
    let calander : NSCalendar = NSCalendar.currentCalendar()
    let activities = ActivityCollection()

    
    let healtkitManager : HealthKitManager = HealthKitManager();
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  let now = NSDate()
       // let day = calander.ordinalityOfUnit(.CalendarUnitDay, inUnit: .CalendarUnitYear, forDate: now)

        
        
        endDate = NSDate()
        let today = NSDateComponents();
        today.year = 2015
        today.month = 11
        today.day = 12
        today.hour = 0;
        today.minute = 0;
        today.second = 1;
        let todayEnd = NSDateComponents();
        todayEnd.year = 2015
        todayEnd.month = 11
        todayEnd.day = 12
        todayEnd.hour = 23;
        todayEnd.minute = 59;
        todayEnd.second = 59;
        startDate = calander.dateFromComponents(today)!
        endDate = calander.dateFromComponents(todayEnd)!
        
        healtkitManager.authorizeHealthKit { (success, error) -> Void in

            if success{
                
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
                        
                      /*  let todayStart = NSDateComponents();
                        todayStart.hour = 0;
                        todayStart.minute = 0;
                        todayStart.second = 1;
                        
                        let todayEnd = NSDateComponents();
                        todayEnd.hour = 23;
                        todayEnd.minute = 59;
                        todayEnd.second = 59;

                        
                        
                        let todayStartDate : NSDate = self.calander.dateFromComponents(todayStart)!;
                        let todayEndDate : NSDate = self.calander.dateFromComponents(todayEnd)!;
                        */
                        
                        //let activity : Activity = Activity(startDate: todayStartDate, endDate: todayEndDate, type: .active)
                        
                        //self.activities.addActivity(activity)
                        
                        for sample in samples{
                            self.activities.addActivity(Activity(startDate: sample.startDate, endDate: sample.endDate, type: .active))
                            print("\(sample.startDate.description) \(sample.endDate.description) " )
                            
                            
                        }
                        self.setChart(["Active", "Inactive"], values: self.activities.getActiveAndInactivePercentageAsArray())

                        
                    }
                 
                })
                
                self.healtkitManager.healthKitStore.executeQuery(query)
            }
    }
    }
    
    func setChart(dataPoints: [String], values: [Int]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: Double(values[i]), xIndex: i)
            dataEntries.append(dataEntry)
        }
        pieChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "activity")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        pieChartView.descriptionText = ""
       // pieChartView.centerText = "Hello, I'm center text";
        
        
        var colors: [UIColor] = []
        colors.append(UIColor( red: 0, green: 0, blue: 255, alpha: 1));
        colors.append(UIColor( red: 255, green: 0, blue: 0, alpha: 1));
        
            
            
            //let red = Double(arc4random_uniform(256))
            //let green = Double(arc4random_uniform(256))
            //let blue = Double(arc4random_uniform(256))
            
            //let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            //colors.append(color)
        //}
        pieChartView.legend.enabled = false
        
        pieChartDataSet.colors = colors
    }
    
    
    
}

