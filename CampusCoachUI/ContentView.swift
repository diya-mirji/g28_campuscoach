//
//  ContentView.swift
//  CampusCoachUI
//
//  Created by Diya V Mirji on 5/25/23.
//

import SwiftUI

struct ContentView: View {
    
    private var user_data = UserProfileData()
    
    init(user_data: UserProfileData) {
        self.user_data = user_data
    }
    
    var body: some View {
        
        TabView {
            HomeView(user_data: self.user_data)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            SleepView(user_data: self.user_data)
                .tabItem {
                    Image(systemName: "bed.double.fill")
                    Text("Sleep")
                }
            
            FoodView(user_data: self.user_data)
                .tabItem {
                    Image(systemName: "fork.knife")
                    Text("Food")
                }
            
            ActivityView(user_data: self.user_data)
                .tabItem {
                    Image(systemName: "dumbbell.fill")
                    Text("Activity")
                }
            
        }
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        ContentView()
//    }
//}
