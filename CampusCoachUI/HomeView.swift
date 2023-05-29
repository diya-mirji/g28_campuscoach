//
//  HomeView.swift
//  CampusCoachUI
//
//  Created by Diya V Mirji on 5/25/23.
//

import Foundation
import SwiftUI

struct HomeView: View {
    
    @State private var lifestyle_score = 78.0
    @State private var minValue = 0.0
    @State private var maxValue = 100.0
    
    var body: some View {
        NavigationView {
            VStack {
                //Motivational quote
                Text("\"Today is your opportunity to build the tomorrow you want.\" -Ken Poirot")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .italic()
                    .foregroundColor(Color(red:16/255, green:4/255, blue:125/255))
                
                Spacer()
                    .frame(width: 100, height: 50)
                
                //Score Gauge
                Gauge(value: lifestyle_score, in: minValue...maxValue) {
                    Text("Calories")
//                    Image(systemName: "heart.fill")
//                        .foregroundColor(.red)
                } currentValueLabel: {
                    Text("\(Int(lifestyle_score))")
                        .foregroundColor(Color.black)
                }
                .gaugeStyle(ScoreGaugeStyle())
                
                Text("Lifestyle Score")
                    .font(.title3)
                
                Spacer()
                    .frame(width: 100, height: 20)
                
                //App Description
                Text("Campus Coach encourages college students to fit in good wellness habits in their busy lives with suggested recommendations on daily activity, proper sleep, and meal plans according to their lifestyle.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .foregroundColor(.gray)
                
            }
            .navigationTitle("Campus Coach")
        }
        .accentColor(.purple)
    }
}


struct ScoreGaugeStyle: GaugeStyle {
    private var purpleGradient = LinearGradient(gradient: Gradient(colors: [ Color(red: 207/255, green: 150/255, blue: 207/255), Color(red: 107/255, green: 116/255, blue: 179/255) ]), startPoint: .trailing, endPoint: .leading)
 
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
                    .font(.system(size: 80, weight: .bold, design: .rounded))
                    .foregroundColor(.gray)
                Text("/ 100")
                    .font(.system(.body, design: .rounded))
                    .bold()
                    .foregroundColor(.black)
            }
 
        }
        .frame(width: 200, height: 200)
 
    }
 
}


//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//
//    }
//}
