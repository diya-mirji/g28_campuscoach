//
//  ActivityView.swift
//  CampusCoachUI
//
//  Created by Diya V Mirji on 5/25/23.
//

import Foundation
import SwiftUI

struct ActivityView: View {
    
    let workouts = workoutsData
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                //Main Card View
                ZStack {
                    Image("personaltrainer")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 300)
                        .background(Color(red: 0.62, green: 0.59, blue: 1.0))
                    
                    
                    VStack {
                            Spacer()
                            Text("Full Body Workout")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Text("For Beginners")
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                        }
                        
                        .padding()
                        .frame(width: 300)
                        //.background(Color.indigo).opacity
                }
                .frame(width: 400, height: 300)
                .cornerRadius(20)
                .clipped()
                // Can remove shadow later may be not needed
                //.shadow(radius: 8)
                //.padding(.top, 20)
                
            
                Text("Weekly Plan")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding()
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 30) {
                        
                        ForEach(workouts) { workout in
                                // NOTE NEED TO FIGURE THIS OUT
                            NavigationLink(destination: ActivityDetailView(workout: workout)) {
            
                            }
                                
                            
                        
                            
                                ZStack {
                                    Image(workout.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 220)
                                        .background(Color(red: 0.62, green: 0.59, blue: 1.0))
                                    
                                    VStack {
                                        
                                        Spacer()
                                        Text(workout.day)
                                            .font(.title)
                                            .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        Text(workout.bodyPart)
                                            .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    }
                                    .padding()
                                    .frame(width: 150)
                                    //.background(Color.indigo).opacity
                                }
                                .frame(width: 150, height: 220)
                                .clipped()
                            .cornerRadius(20)
                            }
                            
                        }
                        
                        
                        
                    }
                    .padding()

                }
                .offset(x: 0, y: -40)
                //.frame(width: 400, height: 800)
                //.background(Color(red: 0.42, green: 0.39, blue: 1.0))
                Spacer()
                .frame(width: 400, height: 800)
                
            }
            .navigationBarTitle("Workouts")
            
        }
    }
    
//}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}


struct Workout: Identifiable {
    //variable ID is being set to the returned unique identifier generated from the method UUID()
    var id = UUID()
    
    //variable names with their respective types
    var day: String
    var bodyPart: String
    var image: String
    var routine: [String]
}

let workoutsData = [
    Workout(day: "Monday", bodyPart: "Chest", image: "runningstart", routine: ["Warmup", "Pushups", "Cool Down"]),
    Workout(day: "Tuesday", bodyPart: "Body", image: "meditation", routine: ["Warmup", "Pullups", "Cool Down"]),
    Workout(day: "Wednesday", bodyPart: "Arms", image: "twoworkout", routine: ["Warmup", "Curls", "Cool Down"])
]

