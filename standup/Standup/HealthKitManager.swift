//
//  HealthKitManager.swift
//  standup
//
//  Created by Fhict on 11/11/15.
//  Copyright © 2015 SMIOS7 Healthkit. All rights reserved.
//

import Foundation
import HealthKit


class HealthKitManager {
    
    let healthKitStore:HKHealthStore = HKHealthStore()
    
    func authorizeHealthKit(completion: ((success: Bool, error: NSError!) -> Void )!) {
        
        //1. Set the types you want to read from HK Store
        let healthKitTypesToRead: [AnyObject?] = [
            HKObjectType.categoryTypeForIdentifier(HKCategoryTypeIdentifierAppleStandHour),
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount),

            HKObjectType.workoutType()
            //HKObjectType.characteristicTypeForIdentifier(HKCategoryTypeIdentifierAppleStandHour),
            //HKObjectType.workoutType()
        ]
        
        //2. set the types you want to write to HK store
        
        let healthKitTypesToWrite: [AnyObject?] = [
          //  HKObjectType.categoryTypeForIdentifier(HKCategoryTypeIdentifierAppleStandHour),
         //   HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount),

        ]
        
        if !HKHealthStore.isHealthDataAvailable() {
            
            let error = NSError(domain: "edu.fontys.HealthKit.Standup", code: 2, userInfo: [NSLocalizedDescriptionKey: "HealthKit is not available on this Device"])
            if (completion != nil) {
                completion(success: false, error: error)
            }
            return;
        }
        
        //4. Request Healthkit Authorization
        
        let sampleTypes = Set(healthKitTypesToRead.flatMap { $0 as? HKSampleType })
        let sampleTypes2 = Set(healthKitTypesToWrite.flatMap  { $0 as? HKSampleType })
        
        healthKitStore.requestAuthorizationToShareTypes(sampleTypes2, readTypes: sampleTypes){
            (success, error) -> Void in
            
            if (completion != nil) {
                completion(success: success, error: error)
            }

            
        }
        healthKitStore.requestAuthorizationToShareTypes(nil, readTypes: sampleTypes) {
            
            (success, error) -> Void in
            
            if (completion != nil) {
                completion(success: success, error: error)
            }
            
        }
    }
}
