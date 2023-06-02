//
//  ActivityDetailView.swift
//  CampusCoachUI
//
//  Created by Christian Phan on 5/28/23.
//

import SwiftUI

struct ActivityDetailView: View {
    
    var workout: Workout
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(workout.day)
                .padding(.leading, 30)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(workout.bodyPart)
                .padding(.leading, 30)
                .font(.title)
            
            List(workout.routine, id: \.self) { exercise in
                Text(exercise)
            }
            
        }
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(workout: Workout(day: "Monday", bodyPart: "Abs", image: "stabilityball", routine: ["Warmups", "planks", "situps"]))
    }
}
