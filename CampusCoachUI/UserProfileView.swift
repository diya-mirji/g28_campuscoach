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
    @State private var birthdate = Date()
    
    @State private var shouldNap = false
    @State private var wakeUpTime = Date()
    @State private var sleepTime = Date()
    
    @State private var startTime = Date()
    @State private var duration = "" //change into int later
    @State private var stepsGoal = "" //change into int later
    
    @State private var calories = "" //change into int later
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    DatePicker("Birthdate", selection: $birthdate, displayedComponents: .date)
                }
                
                Section(header: Text("Sleep Preferences")) {
                    DatePicker("Time You Wake Up", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                    DatePicker("Time You Sleep", selection: $sleepTime, displayedComponents: .hourAndMinute)
                    //Toggle("Nap", isOn: $shouldNap)
                    //    .toggleStyle(SwitchToggleStyle(tint: .purple))
                }
                
                //EDIT ACTIVITY PREFERENCES AFTER IMPLEMENTING WORKOUT INFO
                Section(header: Text("Activity Preferences")) {
                    DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                    TextField("Duration (minutes)", text: $duration) //maybe a picker
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
        print("user saved!")
        print("\(firstName), \(lastName), \(birthdate)")
        print("\(shouldNap), \(wakeUpTime), \(sleepTime)")
        print("\(startTime), \(duration), \(stepsGoal)")
        print("\(calories)")
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for: nil)
    }
}
#endif
