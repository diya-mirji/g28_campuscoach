//
//  FoodView.swift
//  CampusCoachUI
//
//  Created by Diya V Mirji on 5/25/23.
//

import Foundation
import SwiftUI

struct FoodView: View {
    

    @ObservedObject var userprofileVM = UserProfileModel()
    //@State private var daily_calories = 1789.0 //from user profile

    private var daily_calories = 1789.0 //from user profile

    @State private var minValue = 0.0
    private var maxValue = 2000.0
    //maxValue should be the daily calories the user needs (2000/2500)
    
    private var user_data = UserProfileData()
    
    init(user_data: UserProfileData) {
        self.user_data = user_data
        self.daily_calories = Double(self.user_data.getCalories())
        self.maxValue = Double(self.user_data.getRightCalories())
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                Gauge(value: daily_calories, in: minValue...maxValue) {
                    HStack{
                        Text("Daily Calorie Intake")
                            .font(.title2)
                        Image(systemName: "carrot")
                            .foregroundColor(Color.pink)
                    }
                } currentValueLabel: {
                    Text("\(Int(daily_calories)) cal")
                        .bold()
                        .font(.title3)
                } minimumValueLabel: {
                    Text("\(Int(minValue))")
                } maximumValueLabel: {
                    Text("\(Int(maxValue))")
                }
                .tint(Gradient(colors: [ Color(red: 207/255, green: 150/255, blue: 207/255), Color(red: 107/255, green: 116/255, blue: 179/255) ]))
                .frame(width:320, height: 50)
                
                
                
                Spacer()
                    .frame(width: 100, height: 60) //20
                
                //Breakfast Box
                Link(destination: URL(string: "https://www.apple.com")!) {
                    HStack{
                        VStack {
                            Text("Breakfast")
                                .font(.title2)
                                .bold()
                            
                            Text("000 Calories")
                                .italic()
                                .bold()
                            
                            Spacer()
                                .frame(width: 60, height: 10)
                            
                            Text("Name of Dish")
                                .fontWeight(.heavy)
                            
                            Text("Cuisine: Cuisine")
                                .italic()
                        }
                        //.multilineTextAlignment(.leading)
                        
                        Spacer()
                            .frame(width: 30, height: 20)
                        
                        Image(systemName: "birthday.cake.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:80, height:80)
                        
                        Spacer()
                            .frame(width: 20, height: 20)
                        
                        Image(systemName: "arrowshape.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:20, height:20)
                        
                    }
                    .frame(width:320, height:120)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                
                //Lunch Box
                Link(destination: URL(string: "https://www.google.com")!) {
                    HStack{
                        VStack {
                            Text("Lunch")
                                .font(.title2)
                                .bold()
                            
                            Text("000 Calories")
                                .italic()
                                .bold()
                            
                            Spacer()
                                .frame(width: 60, height: 10)
                            
                            Text("Name of Dish")
                                .fontWeight(.heavy)
                            
                            Text("Cuisine: Cuisine")
                                .italic()
                        }
                        //.multilineTextAlignment(.leading)
                        
                        Spacer()
                            .frame(width: 30, height: 20)
                        
                        Image(systemName: "birthday.cake.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:80, height:80)
                        
                        Spacer()
                            .frame(width: 20, height: 20)
                        
                        Image(systemName: "arrowshape.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:20, height:20)
                        
                    }
                    .frame(width:320, height:120)
                    .background(Color.indigo)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                
                //Dinner Box
                Link(destination: URL(string: "https://www.youtube.com")!) {
                    HStack{
                        VStack {
                            Text("Dinner")
                                .font(.title2)
                                .bold()
                            
                            Text("000 Calories")
                                .italic()
                                .bold()
                            
                            Spacer()
                                .frame(width: 60, height: 10)
                            
                            Text("Name of Dish")
                                .fontWeight(.heavy)
                            
                            Text("Cuisine: Cuisine")
                                .italic()
                        }
                        //.multilineTextAlignment(.leading)
                        
                        Spacer()
                            .frame(width: 30, height: 20)
                        
                        Image(systemName: "birthday.cake.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:80, height:80)
                        
                        Spacer()
                            .frame(width: 20, height: 20)
                        
                        Image(systemName: "arrowshape.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:20, height:20)
                        
                    }
                    .frame(width:320, height:120)
                    .background(Color(red:16/255, green:4/255, blue:125/255))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
            }
            .navigationTitle("Food")
        }
        .accentColor(.purple)
        .onAppear() {
            do {
                self.userprofileVM.getUserProfile()
                daily_calories = Double(userprofileVM.user_data.getCalories())
            } catch {
                print("error fetching data")
            }
        }
    }
}




//struct FoodView_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodView()
//
//    }
//}
