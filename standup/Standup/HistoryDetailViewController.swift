//
//  HistoryDetailViewController.swift
//  standup
//
//  Created by Fhict on 26/11/15.
//  Copyright © 2015 SMIOS7 Healthkit. All rights reserved.
//

import UIKit
import Charts

class HistoryDetailViewController: UIViewController {
    
    @IBOutlet weak var testlabel: UILabel!
    
    @IBOutlet weak var piechart: PieChartView!
    let dateFormatter = NSDateFormatter()

    
    var passedValue : ActivityCollection!
    
    
    
    override func viewDidLoad() {
        
        testlabel.text = passedValue.dateWithFormat(dateformat: dateFormats.full)
        setChart(["Active", "Inactive"], values: passedValue.getActiveAndInactivePercentageAsArray())
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
        piechart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "")
        pieChartDataSet.colors = colors
        
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        piechart.data = pieChartData
        piechart.descriptionText = "Overzicht actief / inactief"
        
        piechart.centerText = "\(passedValue.dateWithFormat(dateformat: dateFormats.simple)))"
        
        
    }

    

}
