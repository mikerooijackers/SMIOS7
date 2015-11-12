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

class TodayViewController: UIViewController{
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    let months = ["1", "0", "1", "0", "1", "0"]
    let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
    
    
    
    let healtkitManager : HealthKitManager = HealthKitManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        healtkitManager.authorizeHealthKit { (success, error) -> Void in
        self.setChart(self.months, values: self.unitsSold)

            if success{
                //let hkSampleType:HKSampleType = HKSampleType.correlationTypeForIdentifier(HKCorrelationTypeIdentifierFood)!
                /*let hkSampleType:HKSampleType = HKSampleType.categoryTypeForIdentifier(HKCategoryTypeIdentifierAppleStandHour)!
                
                let query = HKSampleQuery(sampleType: hkSampleType, predicate: nil, limit: 80, sortDescriptors: nil, resultsHandler: { (query:HKSampleQuery, results:[HKSample]?, error:NSError?) -> Void in
                    
                    if let sample = results{
                        
                        
                        
                    }
                 
                })
                
                self.healtkitManager.healthKitStore.executeQuery(query)
                
                
                print("Healthkit is connecte")*/

            }
        }
        
        // Do any additional setup after loading the view.
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        pieChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        pieChartView.centerText = "Hello, I'm center text";
        
        
        var colors: [UIColor] = []
        
        //for _ in 0..<dataPoints.count {
            
            for(var i = 0; i < dataPoints.count; i++){
                if(months[i] == "1"){
                    colors.append(UIColor( red: 0, green: 0, blue: 255, alpha: 1));
                }else{
                    colors.append(UIColor( red: 255, green: 0, blue: 0, alpha: 1));

                }
            }
            
            
            //let red = Double(arc4random_uniform(256))
            //let green = Double(arc4random_uniform(256))
            //let blue = Double(arc4random_uniform(256))
            
            //let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            //colors.append(color)
        //}
        
        pieChartDataSet.colors = colors
       
        
    }
    
    
    
}

