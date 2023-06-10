//
//  UserProfileView.swift
//  CampusCoachUI
//
//  Created by Diya V Mirji on 5/25/23.
//

import Foundation
import SwiftUI

struct UserProfileView: View {
    @ObservedObject var userprofileVM = UserProfileModel()
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var age = ""

    @State private var lunchtime = Date()
    
    @State private var workoutTime = ""
    
    @State private var calories = ""
    
    
    private var user_data = UserProfileData()
    
    init(user_data: UserProfileData) {
        self.user_data = user_data
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    if (userprofileVM.user_data.getFirstName() == ""){
                        TextField("First Name", text: $firstName)
                    }else{
                        TextField(userprofileVM.user_data.getFirstName(), text: $firstName)
                    }
                    
                    if (userprofileVM.user_data.getLastName() == ""){
                        TextField("Last Name", text: $lastName)
                    }else{
                        TextField(userprofileVM.user_data.getLastName(), text: $lastName)
                    }
                    
                    if (userprofileVM.user_data.getAge() == 0){
                        TextField("Age", text: $age)
                    }else{
                        TextField(String(userprofileVM.user_data.getAge()), text: $age)
                    }

                }
                
                Section(header: Text("Sleep Preferences")) {

                    DatePicker("Lunchtime", selection: $lunchtime, displayedComponents: .hourAndMinute)

                }
                

                Section(header: Text("Activity Preferences"), footer: Text("Workout Duration (minutes)")) {

                    if (userprofileVM.user_data.getWorkoutTime() == 0){
                        Picker("Workout Duration (minutes)", selection: $workoutTime) {
                            ForEach(["10", "20", "30", "60"], id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    } else {
                        Picker(String(userprofileVM.user_data.getWorkoutTime()), selection: $workoutTime) {
                            ForEach(["10", "20", "30", "60"], id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                Section(header: Text("Food Preferences")) {
                    if (userprofileVM.user_data.getCalories() == 0){
                        TextField("Calorie Intake Goal", text: $calories)
                    }else{
                        TextField(String(userprofileVM.user_data.getCalories()), text: $calories)
                    }
                }
                
            }
            .navigationTitle("User Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    
                    Button {
                        hideKeyboard()
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                    
//                    Button("Save", action: saveUser)
                    Button("Save") {
                        saveUser()
                        Task {
                            let success = await userprofileVM.saveUserProfile(user_data: user_data)
                            if success {
                                //yay it worked!
                            } else {
                                print("error saving profile")
                            }
                        }
                    }
                    
                }
            }
        }
        .accentColor(.purple)
        .onAppear() {
            do {
                self.userprofileVM.getUserProfile()
            } catch {
                print("error fetching data")
            }

        }
    }
    
    func saveUser() {
        print("\(self.firstName), \(self.lastName), \(self.age)")
        print("\(self.lunchtime)")
        print("\(self.workoutTime)")
        print("\(self.calories)")
        
        self.user_data.setFirstName(firstName: self.firstName)
        self.user_data.setLastName(lastName: self.lastName)
        self.user_data.setAge(age: self.age)
        
        self.user_data.setLunchtime(lunchtime: self.lunchtime)
        
        self.user_data.setWorkoutTime(workoutTime: self.workoutTime)
        
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
