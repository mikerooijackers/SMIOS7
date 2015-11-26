//
//  File.swift
//  standup
//
//  Created by Fhict on 19/11/15.
//  Copyright © 2015 SMIOS7 Healthkit. All rights reserved.
//

import Foundation
import UIKit


public class DrawRect : UIView{
    
    let seconds = 86400.0
    var activities : [Activity] = [Activity]()
    
    func redrawRect(activities _activities : [Activity]){
            self.activities = _activities
            setNeedsDisplay()
            setNeedsLayout()
            print("Repaint called!")

    }
    
    
    override public func drawRect(rect: CGRect) {
        print("painting the shit out of this thing")
        let context = UIGraphicsGetCurrentContext()
       
        let backgroundRect = CGRect(x: 10.0, y: 0.0, width: rect.width , height: rect.height)
        //rects.append(rectangle)
        CGContextSetRGBFillColor(context, 255, 0, 0, 1.0);
        CGContextSetRGBStrokeColor(context, 255, 0, 0, 40.0);
        CGContextFillRect(context, backgroundRect);

        
        //var rects = [CGRect]()
        let parentHeight = Double(rect.height)
        var currentHeight = 0
        let heightPerSec : Double = parentHeight / seconds
       
        
        var oClock = 0;
        var oclockHeight = 0.0;
        let hourHeight = parentHeight / 24
        
        for(var i = 0; i < 7; i++){
            oClock = oClock + 3;
            oclockHeight = oclockHeight + (hourHeight * 3)
            print("oClock =  \(oClock)")
            
            let rect = CGRect(x: 0, y: oclockHeight, width: 10.0, height: 3.0)
            //rects.append(rectangle)
            CGContextSetRGBFillColor(context, CGFloat(i * 10), 0, CGFloat(i * 10), 1.0);
            CGContextSetRGBStrokeColor(context, CGFloat(i * 10), 0, CGFloat(i * 10), 40.0);
            CGContextFillRect(context, rect);
        }
        
        
        
        
        print("Current height= \(currentHeight), parentHeight = \(parentHeight), heightPerSec= \(heightPerSec)")

        
        for(var i = 0; i < activities.count; i++){
            let rectHeight = activities[i].getTimeInteval() * heightPerSec
            
            print("Startdate = \(activities[i].startDateTime.description) endDate = \(activities[i].endDateTime.description)")
            print("Parent height= \(parentHeight), Current height= \(currentHeight), rectheight = \(rectHeight)")
           
            switch activities[i].activityType!{
                case Activity.ActivityType.active:
                    let rectangle = CGRect(x: 0, y: currentHeight, width: Int(rect.width - 10.0), height: Int(rectHeight))
                    //rects.append(rectangle)
                    CGContextSetRGBFillColor(context, 0, 0, 255.0, 1.0);
                    CGContextSetRGBStrokeColor(context, 0, 0, 255.0, 40.0);
                    CGContextFillRect(context, rectangle);
                    break
                case Activity.ActivityType.inactive:
                    break
            }
        
            currentHeight = currentHeight + Int(rectHeight)
        }
        
       
       
    }
    
    
    
    
}
