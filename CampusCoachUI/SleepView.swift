//
//  SleepView.swift
//  CampusCoachUI
//
//  Created by Diya V Mirji on 5/25/23.
//

import Foundation
import SwiftUI

struct SleepView: View {
    
    private var time_slept = 0.0 //time in bed from hk data
    @State private var minValue = 0.0
    @State private var maxValue = 24.0
    
    private var deep_sleep = 3.4
    private var rem_sleep = 2.6
    
    private var user_age = 0
    private var user_lunchtime = (0, 0)
    
    let navy = Color(red:16/255, green:4/255, blue:125/255)
    
    
    private var user_data = UserProfileData()
    
    init(user_data: UserProfileData) {
        self.user_data = user_data
        self.time_slept = Double(self.user_data.getTimeSlept())
        self.user_age = self.user_data.getAge()
        self.user_lunchtime = self.user_data.getLunchtime()
        print(time_slept, user_age, user_lunchtime)
    }
    
    var body: some View {
        NavigationView {
            VStack() {
                //Time Slept Gauge
                Gauge(value: time_slept, in: minValue...maxValue) {
                    Text("Time Slept")
                } currentValueLabel: {
                    Text("\(Int(time_slept))")
                        .foregroundColor(Color.black)
                }
                .gaugeStyle(SleepGaugeStyle(maxValue: maxValue))

                HStack{
                    Text("Time Slept")
                        .font(.title3)
                    Image(systemName: "powersleep")
                        .foregroundColor(Color.pink)
                }
                
                Spacer()
                    .frame(width: 100, height: 20)
                
                //Deep and REM sleep gauges
                HStack{
                    
                    //deep sleep
                    HStack{
                        Gauge(value: deep_sleep, in: minValue...time_slept) {
                            Text("Deep Sleep")
                        } currentValueLabel: {
                            Text("\(Int(deep_sleep))")
                                .foregroundColor(navy)
                        } minimumValueLabel: {
                            Text("\(Int(minValue))")
                                .foregroundColor(navy)
                        } maximumValueLabel: {
                            Text("\(Int(time_slept))")
                                .foregroundColor(navy)
                        }
                        .tint(.purple)
                        .gaugeStyle(.accessoryCircular)
                        
                        Text("Deep Sleep")
                            .foregroundColor(navy)
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 50)
                        .stroke(.purple, lineWidth: 8))
                    
                    
                    Spacer()
                        .frame(width: 10, height: 40)
                    
                    
                    //rem sleep
                    HStack{
                        Gauge(value: rem_sleep, in: minValue...time_slept) {
                            Text("REM Sleep")
                        } currentValueLabel: {
                            Text("\(Int(rem_sleep))")
                                .foregroundColor(navy)
                        } minimumValueLabel: {
                            Text("\(Int(minValue))")
                                .foregroundColor(navy)
                        } maximumValueLabel: {
                            Text("\(Int(time_slept))")
                                .foregroundColor(navy)
                        }
                        .tint(.indigo)
                        .gaugeStyle(.accessoryCircular)
                        
                        Text("REM Sleep")
                            .foregroundColor(navy)
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 50)
                                    .stroke(.indigo, lineWidth: 8))
                    
                }
                
                Spacer()
                    .frame(width: 10, height: 40)
                
                
                Text("Suggested Nap Times")
                    .font(.title2)
                    .bold()
                
                //Nap Rec 1
                Text(self.suggestNap(when:"before"))//"20 minutes at 2:30pm")
                    .font(.title3)
                    .padding(.horizontal, 60.0)
                    .padding(.vertical, 20.0)
                    .background(navy)
                    .foregroundColor(.white)
                    .cornerRadius(50)
                
                //Nap Rec 2
                Text(self.suggestNap(when: "after"))//"40 minutes at 4:20pm")
                    .font(.title3)
                    .padding(.horizontal, 60.0)
                    .padding(.vertical, 20.0)
                    .background(navy)
                    .foregroundColor(.white)
                    .cornerRadius(50)
                
                
            }
            .navigationTitle("Sleep")
            
        }
        .accentColor(.purple)
        
    }
    
    func suggestNap(when: String) -> String {
        let sleep_hrs = [2: [11, 14], 5: [10, 13], 13: [9, 12], 17: [8, 10], 100: [7, 9]]
        var nap_duration = 0
        
        if self.time_slept < 5 {
            nap_duration = 60
        }
        else {
            var minhr = 0
            var maxhr = 24
            for (_, (a, h)) in sleep_hrs.enumerated() {
                if self.user_age <= a {
                    minhr = h[0]
                    maxhr = h[1]
                    break
                }
            }
            if self.time_slept < Double(minhr) {
                nap_duration = 30
            }
            else if self.time_slept > Double(maxhr) {
                nap_duration = 15
            }
            else {
                nap_duration = 22
            }
        }
        
        if when == "before" {
            return "\(nap_duration) minutes at \(self.user_lunchtime.0 - 1):\(self.user_lunchtime.1)"
        }
        else {
            return "\(nap_duration) minutes at \(self.user_lunchtime.0 + 1):\(self.user_lunchtime.1)"
        }
    }
    
    
    
}


struct SleepGaugeStyle: GaugeStyle {
    private var purpleGradient = LinearGradient(gradient: Gradient(colors: [ Color(red: 207/255, green: 150/255, blue: 207/255), Color(red: 107/255, green: 116/255, blue: 179/255) ]), startPoint: .trailing, endPoint: .leading)

    let myMaxValue: Double

    init(maxValue: Double) {
        self.myMaxValue = maxValue
    }

    func makeBody(configuration: Configuration) -> some View {
        ZStack {

            Circle()
                .foregroundColor(Color(.systemGray6))

            Circle()
                .trim(from: 0, to: 0.75 * configuration.value)
                .stroke(purpleGradient, lineWidth: 20)
                .rotationEffect(.degrees(135))

            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(Color.black, style: StrokeStyle(lineWidth: 10, lineCap: .butt, lineJoin: .round, dash: [1, 34], dashPhase: 0.0))
                .rotationEffect(.degrees(135))

            VStack {
                configuration.currentValueLabel
                    .font(.system(size: 35, weight: .bold, design: .rounded))
                    .foregroundColor(.gray)
                Text("of \(Int(self.myMaxValue))hrs")
                    .font(.system(.body, design: .rounded))
                    .bold()
                    .foregroundColor(.black)
            }

        }
        .frame(width: 160, height: 160)

    }

}



struct SleepView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()

    }
}
