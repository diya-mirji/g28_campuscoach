//
//  LoginView.swift
//  CampusCoachUI
//
//  Created by Diya V Mirji on 5/25/23.
//

import Foundation
import SwiftUI

struct StartView: View {
    private var user_data = UserProfileData()
    //testtest
    var body: some View {
        NavigationView {
            VStack{
                Text("Campus Coach")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                    .frame(width: 100, height: 50)
                
                Image("Campus Coach Diagonal")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350, height: 250)
                
                Spacer()
                    .frame(width: 100, height: 50)
                
                NavigationLink(destination: UserProfileView(user_data: self.user_data), label: {
                    Text("Enter User Info")
                        .bold()
                        .frame(width:280, height:50)
                        //.background(Color.indigo)
                        //.foregroundColor(.white)
                        .background(Color.white)
                        .foregroundColor(Color(red: 0.42, green: 0.39, blue: 1.0))
                        .cornerRadius(10)
                })
                
                NavigationLink(destination: ContentView(user_data: self.user_data), label: {
                    Text("Start")
                        .bold()
                        .frame(width:280, height:50)
                        // Note we can decide this later on
                        .background(Color.indigo)
                        //.background(Color(red: 0.62, green: 0.59, blue: 1.0))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
            }
            .frame(width: 400, height: 800)
            .background(Color(red: 0.42, green: 0.39, blue: 1.0))
        }
        .accentColor(.purple)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
        
    }
}
