//
//  ActivityCollection.swift
//  standup
//
//  Created by Fhict on 05/11/15.
//  Copyright © 2015 SMIOS7 Healthkit. All rights reserved.
//

import Foundation

class ActivityCollection {
    
    var activities = [Activity]()
    private let seconds_day_onepercent = 864.0;
    
    init(){
        
    }
    
    func clearActivities(){
        activities.removeAll()
    }
    
    func addActivity(activity : Activity){
        if activity.activityType == Activity.ActivityType.active{
            self.addInactivity(activity);
        }
    }
    
    private func addInactivity(activityNew : Activity){
        let count = activities.count
        if count > 0{
            let activityBefore = activities[count-1]
            if activityBefore.activityType == Activity.ActivityType.active {
                let inactive = Activity(startDate: activityBefore.endDateTime, endDate: activityNew.startDateTime, type: .inactive)
                activities.append(inactive)
            }
        }
        activities.append(activityNew)
    }
    
    func getActiveAndInactivePercentageAsArray() -> [Int]{
        
        var values = [Int]()
        values.append(getPercentage(Activity.ActivityType.active))
        values.append(100 - values[0])

        
        return values
        
    }
    
    func getPercentage(type : Activity.ActivityType) -> Int{
        
        var totalTimeInSec = 0.0;
        
        
        
        for activity in activities {
            if(activity.activityType == type){
                totalTimeInSec = totalTimeInSec + activity.getTimeInteval()
            }
        }
        
        let percentage = totalTimeInSec / seconds_day_onepercent;
        return Int(percentage)
    }
}
