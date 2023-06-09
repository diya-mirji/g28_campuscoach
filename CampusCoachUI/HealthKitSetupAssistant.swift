//
//  HealthKitSetupAssistant.swift
//  CampusCoachUI
//
//  Created by Diya V Mirji on 6/4/23.
//

import Foundation
import HealthKit

class HealthKitSetupAssistant {
    
    private enum HealthkitSetupError: Error {
        case notAvailableOnDevice
        case dataTypeNotAvailable
    }
    
    class func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthkitSetupError.notAvailableOnDevice)
            return
        }
        
        guard let sex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
              let energy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
              let sleep = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            completion(false, HealthkitSetupError.dataTypeNotAvailable)
            return
        }
        
        let healthKitTypesToRead: Set<HKObjectType> = [sex, energy, sleep]
        
        HKHealthStore().requestAuthorization(toShare: [], read: healthKitTypesToRead) {
            (success, error) in
            completion(success, error)
        }
        
    }
    
    
}
