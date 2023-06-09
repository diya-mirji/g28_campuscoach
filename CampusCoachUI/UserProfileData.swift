//
//  UserProfileData.swift
//  CampusCoachUI
//
//  Created by Diya V Mirji on 5/29/23.
//

import Foundation
import SwiftUI

import HealthKit

class UserProfileData {
    private var uid = UIDevice.current.identifierForVendor?.uuidString
    //from UserProfileView
    private var firstName = ""
    private var lastName = ""
    private var age = 0
    
    private var lunchtime = Date()
    
    private var workoutTime = 0
    
    private var calories = 0
    
    //from HealthKit
    private var sex = ""
    private var rightCalories = 0
    private var energy = 0.56 //Double calories
    private var weekEnergy: [Date: Double] = [:]
    private var timeInBed = 0.0 //Double hours
    private var remSleep = 0.0 //Double hours
    private var deepSleep = 0.0 //Double hours
    

    
    
    //healthkit functions
    func readSex() throws {
        
        let sex = try HKHealthStore().biologicalSex().biologicalSex
        var string_sex = ""
        
        if sex == HKBiologicalSex.female {
            string_sex = "female"
        }
        else if sex == HKBiologicalSex.male {
            string_sex = "male"
        }
        else if sex == HKBiologicalSex.notSet {
            string_sex = "notSet"
        }
        else {
            string_sex = "other"
        }
        self.sex = string_sex
        print("userprofiledata, sex", self.sex)
    }
    
    func readEnergy(the_day: Date) {
        guard let energyType = HKSampleType.quantityType(forIdentifier: .activeEnergyBurned) else {
            print("activeEnergyBurned Sample type not available")
            return
        }
        
        let dailyPredicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: the_day), end: the_day, options: .strictEndDate)
        
        var total = 0.0
        let energyQuery = HKSampleQuery(sampleType: energyType, predicate: dailyPredicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, sample, error) in
            guard let samples = sample as? [HKQuantitySample] else {
                return
            }

            total = samples.reduce(0.0, {$0 + $1.quantity.doubleValue(for: HKUnit.smallCalorie())}) //quantitySamples.quantity.doubleValue(for: HKUnit.smallCalorie())  //quantitySamples.reduce(0.0) { $0 + $1.quantity.doubleValue(for: HKUnit.largeCalorie()) }
            self.weekEnergy[the_day] = total
            self.energy = total

        }
        HKHealthStore().execute(energyQuery)

    }
    
    func storeWeekEnergy() {
        let today = Date()
        for i in 1...6 {
            let a_day = Calendar.current.date(byAdding: .day, value: -i, to: today) ?? Date()
            self.readEnergy(the_day: a_day)
        }
    }
    
    
    
    func readTimeInBed() {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            print("sleepAnalysis Object type not available")
            return
        }
        
        let now = Date()
        let startBed = Calendar.current.date(byAdding: .hour, value: -24, to: now)
        let dayAgoPredicate = HKQuery.predicateForSamples(withStart: startBed, end: now, options: .strictEndDate)
        
        let sleepQuery = HKSampleQuery(sampleType: sleepType, predicate: dayAgoPredicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, sample, error) in
            guard
                error == nil,
                let categorySamples = sample?.first as? HKCategorySample else {
                    print("Something went wrong here: \(error)")
                    return
                }
            let startDate = categorySamples.startDate
            let endDate = categorySamples.endDate
            let components = self.computeDiffDate(fromDate: startDate, toDate: endDate)

            self.timeInBed = Double(components.0 ?? 0) + (Double(components.1 ?? 0)/60.0)
            print("userprofiledata, timeInBed", self.timeInBed)

        }
        
        HKHealthStore().execute(sleepQuery)
    }
    
    func readREMDeepSleep() {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            print("sleepAnalysis Object type not available")
            return
        }
        
        let now = Date()
        let startBed = Calendar.current.date(byAdding: .hour, value: -24, to: now)
        let dayAgoPredicate = HKQuery.predicateForSamples(withStart: startBed, end: now, options: .strictEndDate)
        let allAsleepPredicate = HKCategoryValueSleepAnalysis.predicateForSamples(equalTo: [.asleepREM, .asleepDeep])
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [dayAgoPredicate, allAsleepPredicate])
        
        let sleepQuery = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, sample, error) -> Void in
            if error != nil {
                print("Something went wrong in readREMSleep: \(error)")
                return
            }
            if let result = sample {
                for item in result {
                    if let sample = item as? HKCategorySample {
                        if sample.value == HKCategoryValueSleepAnalysis.asleepREM.rawValue {
                            let components = self.computeDiffDate(fromDate: sample.startDate, toDate: sample.endDate)
                            self.remSleep = Double(components.0 ?? 0) + (Double(components.1 ?? 0)/60.0)
                            print("Healthkit sleep: \(sample.startDate) \(sample.endDate) - value: REM")
                        } else {
                            let components = self.computeDiffDate(fromDate: sample.startDate, toDate: sample.endDate)
                            self.deepSleep = Double(components.0 ?? 0) + (Double(components.1 ?? 0)/60.0)
                            print("Healthkit sleep: \(sample.startDate) \(sample.endDate) - value: \(sample.value)")
                        }
                    }
                }
            }
        }
        HKHealthStore().execute(sleepQuery)
    }
    
    
    
    
    //setters
    func setFirstName(firstName: String) {
        if firstName != "" {
            self.firstName = firstName
        }
    }
    func setLastName(lastName: String) {
        if lastName != "" {
            self.lastName = lastName
        }
    }
    func setAge(age: String) {
        if age != "" {
            self.age = Int(age) ?? 0
        }
    }

    func setLunchtime(lunchtime: Date) {
        self.lunchtime = lunchtime
    }
    
    func setWorkoutTime(workoutTime: String) {
        self.workoutTime = Int(workoutTime) ?? 10
    }
    
    func setCalories(calories: String) {
        if calories != "" {
            self.calories = Int(calories) ?? 0
        }
    }
    
    
    
    //getters
    func getUserId() -> String {
        return self.uid!
    }
    func getFirstName() -> String {
        return self.firstName
    }
    func getLastName() -> String {
        return self.lastName
    }
    func getAge() -> Int {
        return self.age
    }
    
    func getLunchtime() -> (hour: Int, minute: Int) {
        return getDateTime(myDate: self.lunchtime)
    }
    
    func getWorkoutTime() -> Int {
        return self.workoutTime
    }
    
    func getCalories() -> Int {
        return self.calories
    }
    
    func getSex() -> String {
        return self.sex
    }
    func getRightCalories() -> Int {
        return self.rightCalories
    }
    func getEnergy() -> Double {
        return self.energy
    }
    func getWeekEnergy() -> [Date: Double] {
        self.storeWeekEnergy()
        return self.weekEnergy
    }
    func getTimeInBed() -> Double {
        return self.timeInBed
    }
    func getREMSleep() -> Double {
        return self.remSleep
    }
    func getDeepSleep() -> Double {
        return self.deepSleep
    }
    
    
    
    
    //extras
    func computeDiffDate(fromDate: Date, toDate: Date) -> (hour: Int?, minute: Int?) {
        let diffComponents = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate)
        return (diffComponents.hour, diffComponents.minute)
    }
    
    func getDateTime(myDate: Date) -> (hour: Int, minute: Int) {
        let calendar = Calendar.current
        return (calendar.component(.hour, from: myDate), calendar.component(.minute, from: myDate))
    }
    
    func calcRightCalories() {
        if self.sex == "notSet" {
            self.rightCalories = 2400
        }
        else if self.sex == "other" {
            self.rightCalories = 2400
        }
        else if self.sex == "female" {
            self.rightCalories = 2000
        }
        else if self.sex == "male" {
            self.rightCalories = 2700
        }
    }
    
    func calcFoodScore() -> Double {
        let score = Double(self.calories)/Double(self.rightCalories) * 30
        print("food \(score)")
        return score
    }
    
    func calcActivityScore() -> Double {
        let score = Double(self.energy)/Double(300) * 40
        print("activity \(score)")
        return score
    }

    func calcSleepScore() -> Double {
        var score = 0.0
        if self.timeInBed <= 5 {
            score = 10.0
        }
        else if self.timeInBed <= 7 {
            score = 20.0
        }
        else {
            score = 30.0
        }
        print("sleep \(score)")
        return score
    }
    
    func calcLifestyleScore() -> Double {
        return self.calcFoodScore() + self.calcActivityScore() + self.calcSleepScore()
    }
    
    
    
}
