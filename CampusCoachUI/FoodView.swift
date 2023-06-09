//
//  FoodView.swift
//  CampusCoachUI
//
//  Created by Diya V Mirji on 5/25/23.
//

import Foundation
import SwiftUI

struct Meal: Codable {
    var readyInMinutes: Int
    var sourceUrl: String
    var servings: Int
    var id: Int
    var title: String
    var imageType: String
}

struct MealsResponse: Codable {
    var meals: [Meal]
    var nutrients: Nutrients
}

struct Nutrients: Codable {
    var fat: Double
    var carbohydrates: Double
    var calories: Double
    var protein: Double
}



struct FoodView: View {
    

    @ObservedObject var userprofileVM = UserProfileModel()
    //@State private var daily_calories = 1789.0 //from user profile

    private var daily_calories = 1789.0 //from user profile

    @State private var minValue = 0.0
    private var maxValue = 2000.0
    //maxValue should be the daily calories the user needs (2000/2500)
    
    @State private var breakfast_dish = "Breakfast Dish"
    @State private var breakfast_servings = "Servings 000"
    @State private var breakfast_url = "https://www.google.com"
    @State private var lunch_dish = "Lunch Dish"
    @State private var lunch_servings = "Servings 000"
    @State private var lunch_url = "https://www.google.com"
    @State private var dinner_dish = "Dinner Dish"
    @State private var dinner_servings = "Servings 000"
    @State private var dinner_url = "https://www.google.com"
    
    
    @State public var dish_list: [String] = []
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
                Link(destination: URL(string: breakfast_url)!) {
                    HStack{
                        VStack {
                            Text("Breakfast")
                                .font(.title2)
                                .bold()
                            
                            Text("Servings: " + breakfast_servings)
                                .italic()
                                .bold()
                            
                            Spacer()
                                .frame(width: 60, height: 10)
                            
                            Text(breakfast_dish)
                                .fontWeight(.heavy)
                            
                        }
                        //.multilineTextAlignment(.leading)
                        
                        Spacer()
                            .frame(width: 30, height: 20)
                        
                        Image(systemName: "sun.max.fill")
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
                Link(destination: URL(string: lunch_url)!) {
                    HStack{
                        VStack {
                            Text("Lunch")
                                .font(.title2)
                                .bold()
                            
                            Text("Servings: " + lunch_servings)
                                .italic()
                                .bold()
                            
                            Spacer()
                                .frame(width: 60, height: 10)
                            
                            Text(lunch_dish)
                                .fontWeight(.heavy)
                            
                        }
                        //.multilineTextAlignment(.leading)
                        
                        Spacer()
                            .frame(width: 30, height: 20)
                        
                        Image(systemName: "fork.knife")
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
                Link(destination: URL(string: dinner_url)!) {
                    HStack{
                        VStack {
                            Text("Dinner")
                                .font(.title2)
                                .bold()
                            
                            Text("Servings: " + dinner_servings)
                                .italic()
                                .bold()
                            
                            Spacer()
                                .frame(width: 60, height: 10)
                            
                            Text(dinner_dish)
                                .fontWeight(.heavy)
                            

                        }
                        //.multilineTextAlignment(.leading)
                        
                        Spacer()
                            .frame(width: 30, height: 20)
                        
                        Image(systemName: "moon.stars.fill")
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

            getFood()
        }
    }
    
    func getFood() {
        
        let headers = [
            "X-RapidAPI-Key": "deb0af99cbmsh6b582ba303a313ap1748f5jsn5b9d96646f40",
            "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/mealplans/generate?timeFrame=day&targetCalories=1789&diet=vegetarian&exclude=shellfish%2C%20olives")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
//                let httpResponse = response as? HTTPURLResponse
                
                if let responseData = data {
                            do {
                                let decoder = JSONDecoder()
                                let mealsResponse = try decoder.decode(MealsResponse.self, from: responseData)
                                let meals = mealsResponse.meals // Access the array of Meal objects
                                for meal in meals {
//                                    dish_list.append(meal.title)
                                    self.breakfast_dish = meal.title
                                    print("Title: \(meal.title), Ready in Minutes: \(meal.readyInMinutes)")
                                }
                                
                                self.breakfast_dish = meals[0].title
                                self.breakfast_servings = String(meals[0].servings)
                                self.breakfast_url = meals[0].sourceUrl
                                self.lunch_dish = meals[1].title
                                self.lunch_servings = String(meals[1].servings)
                                self.lunch_url = meals[1].sourceUrl
                                self.dinner_dish = meals[2].title
                                self.dinner_servings = String(meals[2].servings)
                                self.dinner_url = meals[2].sourceUrl
                                
                                
                            } catch {
                                print("Error parsing JSON: \(error)")
                            }
                        }
                
                print(data as Any)
                
            }
        })
        
        dataTask.resume()
        
    }
    
    
}
