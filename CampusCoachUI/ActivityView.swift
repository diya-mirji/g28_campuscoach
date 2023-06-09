//
//  ActivityView.swift
//  CampusCoachUI
//
//  Created by Diya V Mirji on 5/25/23.
//

import Foundation
import SwiftUI
import Charts

struct ActivityView: View {
    
    private var workout: [[String]] = []//workoutsData
    
    private var user_data = UserProfileData()
    private var workoutTime = 0
    private var elist: [[String]] = []
    private var weekEnergies: [Date:Double] = [:]
    
    
    var viewDates: [ViewDate] = [ //just for testing
        .init(date: Date.from(year: 2023, month: 12, day: 1), caloriesBurned: 300),
        .init(date: Date.from(year: 2023, month: 12, day: 2), caloriesBurned: 400),
        .init(date: Date.from(year: 2023, month: 12, day: 3), caloriesBurned: 900),
        .init(date: Date.from(year: 2023, month: 12, day: 4), caloriesBurned: 20),
        .init(date: Date.from(year: 2023, month: 12, day: 5), caloriesBurned: 100),
        .init(date: Date.from(year: 2023, month: 12, day: 6), caloriesBurned: 140),
        .init(date: Date.from(year: 2023, month: 12, day: 7), caloriesBurned: 160),
//        ViewDate(date: Date(), caloriesBurned: 400),
//        ViewDate(date: Date(), caloriesBurned: 200),
//        ViewDate(date: Date(), caloriesBurned: 500),
//        ViewDate(date: Date(), caloriesBurned: 400),
//        ViewDate(date: Date(), caloriesBurned: 200),
//        ViewDate(date: Date(), caloriesBurned: 500)
    ]
    
    
    init(user_data: UserProfileData) {
        self.user_data = user_data
        self.workoutTime = self.user_data.getWorkoutTime()
        
        if let localData = self.readLocalFile(forName: "exercises") {
            self.elist = self.parse(jsonData: localData)
        }
        
        self.workout = self.getRecommendedWorkout()
        
        self.weekEnergies = self.user_data.getWeekEnergy()
        self.viewDates // convert weekEnergies to viewDates
        let today = Date()
        self.viewDates = [ //for demo
            .init(date: Calendar.current.date(byAdding: .day, value: -6, to: today) ?? today, caloriesBurned: 176.9), .init(date: Calendar.current.date(byAdding: .day, value: -5, to: today) ?? today, caloriesBurned: 21.0), .init(date: Calendar.current.date(byAdding: .day, value: -4, to: today) ?? today, caloriesBurned: 0.0), .init(date: Calendar.current.date(byAdding: .day, value: -3, to: today) ?? today, caloriesBurned: 70.0), .init(date: Calendar.current.date(byAdding: .day, value: -2, to: today) ?? today, caloriesBurned: 0.0), .init(date: Calendar.current.date(byAdding: .day, value: -1, to: today) ?? today, caloriesBurned: 298.00000000000006), .init(date: today, caloriesBurned: 0.0)     ]
        
        
    }
    
    var body: some View {
        NavigationView {
            VStack(/*alignment: .leading*/) {
                
                //Main Card View
                NavigationLink(destination: ActivityDetailView(workout: self.workout), label: {
                    ZStack {
                        Image("personaltrainer")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 300)
                            .background(Color(red: 0.62, green: 0.59, blue: 1.0))
                        
                        
                        VStack {
                            Spacer()
                            Text("Today's Workout")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Text("Recommended for User")
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                        }
                        
                        .padding()
                        .frame(width: 300)
                        //.background(Color.indigo).opacity
                    }
                    .frame(width: 340, height: 300)
                    .cornerRadius(20)
                    .clipped()
                }) //Navigation Link
                
                Spacer()
                    .frame(width: 10, height: 40)
                
                Chart {
                    // Rue Mark is that goal line
                    RuleMark(y: .value("Goal", 300))
                        .foregroundStyle(Color.mint)
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                        .annotation(alignment: .leading) {
                            Text("Goal")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    //Text("Hello, World!")
                    ForEach(viewDates) { viewDate in
                        BarMark(
                            x: .value("Date", viewDate.date),
                            y: .value("Active Energy Burned", viewDate.caloriesBurned)
                        )
                        //                    .annotation(alignment: .top) {
                        //                        Text("\(viewDate.caloriesBurned)")
                        //                            .font(.caption)
                        //                            .foregroundColor(.white)
                        //                            .padding(4)
                        //                            .background(Color.red)
                        //                            .cornerRadius(4)
                    }
                    .foregroundStyle(Color(red: 0.42, green: 0.39, blue: 1.0).gradient)
                    .cornerRadius(0)
                    //.foregroundColor(Color(red: 0.42, green: 0.39, blue: 1.0))
                } //Chart
                .padding(.horizontal, 20)
                .frame(height: 240)
                .chartYScale(domain: 0...1000)
                .chartXAxisLabel("Date")
                .chartYAxisLabel("Active Energy Burned")
                
                
            } //VStack
            .navigationTitle("Activity")
            
            
            
        } //NavigationView
        

    }
    
    
    
    
    
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    struct ExercisesGroup: Codable {
        var exercises: [Exercise]
        
        struct Exercise: Codable {
            var name: String
            var sets: String
            var reps: String
            var time: String
        }
        
    }
    
    private func parse(jsonData: Data) -> [[String]] {
        do {
            let decodedData = try JSONDecoder().decode(ExercisesGroup.self,
                                                       from: jsonData)
            //turn into list of exercises
            var elist: [[String]] = []
            for index in 0...decodedData.exercises.count-1 {
                elist.append( [decodedData.exercises[index].name, decodedData.exercises[index].sets, decodedData.exercises[index].reps, decodedData.exercises[index].time] )
            }
            //print(elist) //
            return elist
            
        } catch {
            print(error)
        }
        return []
    }
    
    func getRecommendedWorkout() -> [[String]]{
        var final_workout: [[String]] = []
        var cur_dur = 0
        var chosenI: [Int] = []
        
        while cur_dur < self.workoutTime {
            let randomI = Int.random(in: 0..<self.elist.count)
            let randomE = self.elist[randomI]
            let randomE_dur = Int(randomE[3]) ?? 0
            
            let calc_dur = cur_dur + randomE_dur
            
            if chosenI.contains(randomI) {
                continue
            }
            else if calc_dur > self.workoutTime {
                continue
            }
            else {
                final_workout.append(randomE)
                chosenI.append(randomI)
                cur_dur = calc_dur
            }
        }
        return final_workout
    }
    
}




struct ViewDate: Identifiable {
    let id = UUID()
    let date: Date
    let caloriesBurned: Double
}

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
}


struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}


