//
//  ContentView.swift
//  CampusCoachUI
//
//  Created by Diya V Mirji on 5/25/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            SleepView()
                .tabItem {
                    Image(systemName: "bed.double.fill")
                    Text("Sleep")
                }
            
            FoodView()
                .tabItem {
                    Image(systemName: "fork.knife")
                    Text("Food")
                }
            
            ActivityView()
                .tabItem {
                    Image(systemName: "dumbbell.fill")
                    Text("Activity")
                }
            
            UserProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("User Profile")
                }
        }
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        //LoginView()
//        //UserProfileView()
//
//        ContentView()
//    }
//}
