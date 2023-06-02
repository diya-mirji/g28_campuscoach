//
//  UserProfileData.swift
//  CampusCoachUI
//
//  Created by Diya V Mirji on 5/29/23.
//

import Foundation

class UserProfileData {
    private var firstName = ""
    private var lastName = ""
    private var age = 0
    
    private var wakeUpTime = Date()
    private var sleepTime = Date()
    private var lunchtime = Date()
    
    private var stepsGoal = 0
    
    private var calories = 0
    
    
    
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
    
    func setWakeUpTime(wakeUpTime: Date) {
        self.wakeUpTime = wakeUpTime
    }
    func setSleepTime(sleepTime: Date) {
        self.sleepTime = sleepTime
    }
    func setLunchtime(lunchtime: Date) {
        self.lunchtime = lunchtime
    }
    
    func setStepsGoal(stepsGoal: String) {
        if stepsGoal != "" {
            self.stepsGoal = Int(stepsGoal) ?? 0
        }
    }
    
    func setCalories(calories: String) {
        if calories != "" {
            self.calories = Int(calories) ?? 0
        }
    }
    
    
    
    //getters
    func getFirstName() -> String {
        return self.firstName
    }
    func getLastName() -> String {
        return self.lastName
    }
    func getAge() -> Int {
        return self.age
    }
    
    func getTimeSlept() -> Double {
        let components = getDateTime(myDate: computeDiffDate(fromDate: self.wakeUpTime, toDate: self.sleepTime))
        print(components)
        return Double(components.0 + components.1/60)
    }
    func getLunchtime() -> (hour: Int, minute: Int) {
        return getDateTime(myDate: self.lunchtime)
    }
    
    func getCalories() -> Int {
        return self.calories
    }
    
    
    
    //extras
    func computeDiffDate(fromDate: Date, toDate: Date) -> Date {
        let delta = toDate.timeIntervalSinceReferenceDate - fromDate.timeIntervalSinceReferenceDate
        // `Date` - `Date` = `TimeInterval`
        let today = Date()
        if delta < 0 {
            return today
        } else {
            return today + delta // `Date` + `TimeInterval` = `Date`
        }
    }
    
    func getDateTime(myDate: Date) -> (hour: Int, minute: Int) {
        let calendar = Calendar.current
        return (calendar.component(.hour, from: myDate), calendar.component(.minute, from: myDate))
    }

    
    
    
}

