//
//  StandupTests.swift
//  StandupTests
//
//  Created by Mike Rooijackers on 19-10-15.
//  Copyright © 2015 SMIOS7 Healthkit. All rights reserved.
//
import XCTest
@testable import Standup

class StandupTests: XCTestCase {
    
    var activites = [Activity]();
    var dateComponents = [NSDateComponents]()
    var dates = [NSDate]()
    let calander : NSCalendar = NSCalendar.currentCalendar()
    var activityCollection = ActivityCollection()
    
    override func setUp() {
        super.setUp()
        let today11clock = NSDateComponents();
        today11clock.year = 2015;
        today11clock.day = 5;
        today11clock.month = 11;
        today11clock.hour = 11;
        today11clock.minute = 0;
        today11clock.second = 0;
        
        let today12clock = NSDateComponents();
        today12clock.year = 2015;
        today12clock.day = 5;
        today12clock.month = 11;
        today12clock.hour = 12;
        today12clock.minute = 0;
        today12clock.second = 0;
        
        
        let today1230clock = NSDateComponents();
        today1230clock.year = 2015;
        today1230clock.day = 5;
        today1230clock.month = 11;
        today1230clock.hour = 12;
        today1230clock.minute = 30;
        today1230clock.second = 0;
        
        let today1245clock = NSDateComponents();
        today1245clock.year = 2015;
        today1245clock.day = 5;
        today1245clock.month = 11;
        today1245clock.hour = 12;
        today1245clock.minute = 45;
        today1245clock.second = 0;
        
        dateComponents.append(today11clock);
        dateComponents.append(today12clock);
        dateComponents.append(today1230clock);
        dateComponents.append(today1245clock);
        
        let today11 : NSDate = calander.dateFromComponents(today11clock)!;
        let today12 : NSDate = calander.dateFromComponents(today12clock)!;
        let today1230 : NSDate = calander.dateFromComponents(today1230clock)!;
        let today1245 : NSDate = calander.dateFromComponents(today1245clock)!;
        
        dates.append(today11)
        dates.append(today12)
        dates.append(today1230)
        dates.append(today1245)
        
        let activity1 : Activity = Activity(startDate: today11, endDate: today12, type: Activity.ActivityType.active)
        let activity2 : Activity = Activity(startDate: today1230, endDate: today1245, type: Activity.ActivityType.active);
        
        activites.append(activity1);
        activites.append(activity2);
    
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    

    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTimeintervalActivities() {
        self.measureBlock {
            let act1 = self.activites[0]
            print(act1.getTimeInteval())
            XCTAssertTrue(act1.getTimeInteval() == 3600, "moet 3600 zijn maar was \(act1.getTimeInteval())")
            
            let act2 = self.activites[1]
            print(act2.getTimeInteval())
            XCTAssertTrue(act2.getTimeInteval() == 900, "moet 900 zijn maar was \(act2.getTimeInteval())")
        }
        
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testInactive() {
        // This is an example of a performance test case.
        self.measureBlock {
            let count = self.activites.count;
            var inactivities = [Activity]()
            
            for(var i = 0; i < self.activites.count; i++){
                
                if i + 1 < count{
                    let first = self.activites[i]
                    let second = self.activites[i+1]
                    let inactive = Activity.init(startDate: first.endDateTime, endDate: second.startDateTime, type: .inactive)
                    inactivities.append(inactive)
                }
            }
            
            XCTAssertTrue(inactivities.count == 1, "Moet 1 zijn maar ");
            XCTAssertTrue(inactivities[0].getTimeInteval() == 1800, "Moet 1800 zijn maar is \(inactivities[0].getTimeInteval())")
            
        }
    }
    
        
        func testActivityCollection(){
            self.activityCollection.addActivity(self.activites[0]);
            self.activityCollection.addActivity(self.activites[1]);
            let count = self.activityCollection.activities.count
            XCTAssertTrue(count == 3, "count moet 3 zijn maar is \(count)")
            XCTAssertTrue(self.activityCollection.activities[0].activityType == Activity.ActivityType.active, "Moet active zijn maar was inactive")
            XCTAssertTrue(self.activityCollection.activities[1].activityType == Activity.ActivityType.inactive, "Moet inactive zijn maar was active")
            XCTAssertTrue(self.activityCollection.activities[2].activityType == Activity.ActivityType.active, "Moet active zijn maar was inactive")
            let inactive = self.activityCollection.activities[1]
            XCTAssertTrue(inactive.getTimeInteval() == 1800, "Interval moet 1800 seconden zijn maar was \(inactive.getTimeInteval())")
    }
    
    func testTotalActivePercentage(){
        self.activityCollection.addActivity(self.activites[0]);
        self.activityCollection.addActivity(self.activites[1]);
        //1.15 = 4500
        let percentageActive = activityCollection.getPercentage(Activity.ActivityType.active)
      // let percentageInactive = activityCollection.getPercentage(Activity.ActivityType.inactive)
        
        XCTAssertTrue(percentageActive == 5, "percentage moet 5.208 zijn maar is \(percentageActive)")
    }
    
    func testActivityPercentage(){
        self.activityCollection.addActivity(self.activites[0]);
        self.activityCollection.addActivity(self.activites[1]);
        
        let act = self.activityCollection.activities[0];
        
        let percentage = act.getPercentageOfDay();
        
        XCTAssertTrue(percentage == 4, "Percentage moet 4.166 zijn maar is \(percentage)")
        
        
        
    }
    
    
    
}
    
    
    
    
    
    
    
    
    
    
    
    
    

