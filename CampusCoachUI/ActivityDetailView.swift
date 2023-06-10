//
//  ActivityDetailView.swift
//  CampusCoachUI
//
//  Created by Christian Phan on 5/28/23.
//

import SwiftUI

struct ActivityDetailView: View {
    
    var workout: [[String]] = []
    
    init(workout: [[String]]) {
        self.workout = workout
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Exercises")
                .padding(.leading, 30)
                .font(.title)
                .fontWeight(.semibold)

            
            List(workout, id: \.self) { exercise in
                Text(exercise[0])
                    .font(.title3)
                    .fontWeight(.semibold)
                Text("      \(exercise[1]) sets")
                Text("      \(exercise[2]) reps")
                Text("      \(exercise[3]) minutes")
            }
            
        }
    }
}

//struct ActivityDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityDetailView(workout: [["Dumbbell Shoulder Raises", "3", "10", "10"], ["Push-down", "3", "12", "10"], ["Overhead Tricep Extension", "3", "10", "10"]])
//    }
//}
