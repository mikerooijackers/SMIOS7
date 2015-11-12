//
//  Activity.swift
//  standup
//
//  Created by Fhict on 05/11/15.
//  Copyright © 2015 SMIOS7 Healthkit. All rights reserved.
//

import Foundation


public class Activity{
    
    private let seconds_day = 86400.0;
    private let seconds_day_onepercent = 864.0;
    
    
    enum ActivityType{
        case active
        case inactive
    }
    
    
    let activityType : ActivityType!;
    let startDateTime : NSDate;
    let endDateTime : NSDate;
    
    
    init(startDate : NSDate, endDate : NSDate, type : ActivityType){
        self.activityType = type;
        self.startDateTime = startDate;
        self.endDateTime = endDate;
    }
    
    /*func initializeInactivity(start : Activity, end : Activity) -> Activity{
        
        return Activity(startDate: start.endDateTime, endDate: end.startDateTime, type: .inactive)
    }*/
    
    
    func getTimeInteval() -> NSTimeInterval{
        return endDateTime.timeIntervalSinceDate(startDateTime);
    }
  
    func getPercentageOfDay() -> Int{
        let percentage = getTimeInteval() / seconds_day_onepercent;
        return Int(percentage)
    }
    
    
}