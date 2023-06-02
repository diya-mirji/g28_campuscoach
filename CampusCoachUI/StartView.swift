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
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Campus Coach")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                    .frame(width: 100, height: 50)
                
                Image(systemName: "figure.run.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 300)
                
                Spacer()
                    .frame(width: 100, height: 50)
                
                NavigationLink(destination: UserProfileView(user_data: self.user_data), label: {
                    Text("Enter User Info")
                        .bold()
                        .frame(width:280, height:50)
                        .background(Color.indigo)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
                
                NavigationLink(destination: ContentView(user_data: self.user_data), label: {
                    Text("Start")
                        .bold()
                        .frame(width:280, height:50)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
            }
        }
        .accentColor(.purple)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
        
    }
}
