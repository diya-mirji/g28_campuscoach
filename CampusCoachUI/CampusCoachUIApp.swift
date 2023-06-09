//
//  CampusCoachUIApp.swift
//  CampusCoachUI
//
//  Created by Diya V Mirji on 5/25/23.
//

import SwiftUI
import FirebaseCore

@main
struct CampusCoachUIApp: App {
    
    init() {
        FirebaseApp.configure()
        print("Configured Firebase!")
    }
    var body: some Scene {
        WindowGroup {
            StartView()
            //ContentView()
        }
    }
}
