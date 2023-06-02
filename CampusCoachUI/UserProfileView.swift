//
//  UserProfileView.swift
//  CampusCoachUI
//
//  Created by Diya V Mirji on 5/25/23.
//

import Foundation
import SwiftUI

struct UserProfileView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var age = ""
    //@State private var birthdate = Date()
    
    //@State private var shouldNap = false
    @State private var wakeUpTime = Date()
    @State private var sleepTime = Date()
    @State private var lunchtime = Date()
    
    //@State private var startTime = Date()
    //@State private var duration = "" //change into int later
    @State private var stepsGoal = "" //change into int later
    
    @State private var calories = "" //change into int later
    
    
    private var user_data = UserProfileData()
    
    init(user_data: UserProfileData) {
        self.user_data = user_data
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Age", text: $age)
                    //DatePicker("Birthdate", selection: $birthdate, displayedComponents: .date)
                }
                
                Section(header: Text("Sleep Preferences")) {
                    DatePicker("Time You Wake Up", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                    DatePicker("Time You Sleep", selection: $sleepTime, displayedComponents: .hourAndMinute)
                    DatePicker("Lunchtime", selection: $lunchtime, displayedComponents: .hourAndMinute)
                    //Toggle("Nap", isOn: $shouldNap)
                    //    .toggleStyle(SwitchToggleStyle(tint: .purple))
                }
                
                //EDIT ACTIVITY PREFERENCES AFTER IMPLEMENTING WORKOUT INFO
                Section(header: Text("Activity Preferences")) {
                    //DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                    //TextField("Duration (minutes)", text: $duration) //maybe a picker
                    TextField("Steps Goal", text: $stepsGoal)
                }
                
                Section(header: Text("Food Preferences")) {
                    TextField("Daily Calorie Intake Goal", text: $calories)
                }
                
            }
            .navigationTitle("User Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    //Image(systemName: "person")
                    
                    Button {
                        hideKeyboard()
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                    
                    Button("Save", action: saveUser)
                    
                }
            }
        }
        .accentColor(.purple)
    }
    
    func saveUser() {
        print("\(self.firstName), \(self.lastName), \(self.age)")
        print("\(self.wakeUpTime), \(self.sleepTime), \(self.lunchtime)")
        print("\(self.stepsGoal)")
        print("\(self.calories)")
        
        self.user_data.setFirstName(firstName: self.firstName)
        print(self.user_data.getFirstName())
        self.user_data.setLastName(lastName: self.lastName)
        self.user_data.setAge(age: self.age)
        
        self.user_data.setWakeUpTime(wakeUpTime: self.wakeUpTime)
        self.user_data.setSleepTime(sleepTime: self.sleepTime)
        //print(self.user_data.getTimeSlept())
        self.user_data.setLunchtime(lunchtime: self.lunchtime)
        
        self.user_data.setStepsGoal(stepsGoal: self.stepsGoal)
        
        self.user_data.setCalories(calories: self.calories)
        
        print("user saved!")
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for: nil)
    }
}
#endif
