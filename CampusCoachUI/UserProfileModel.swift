//
//  UserProfileModel.swift
//  CampusCoachUI
//
//  Created by Rithu Eswaramoorthy on 6/4/23.
//

import Foundation
import FirebaseFirestore

class UserProfileModel: ObservableObject {
    @Published var user_data = UserProfileData()
    private var uid = UIDevice.current.identifierForVendor?.uuidString
    var userID = ""
    
    init(){
        getUserProfile()
    }
    
    func saveUserProfile(user_data: UserProfileData) async -> Bool {
        let db = Firestore.firestore()
        let query = db.collection("users").whereField("uid", isEqualTo: uid!)
        var updatedDatabase = false
        
        query.getDocuments() { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else if snapshot != nil {
                var dictionary: [String: Any] {
                    return ["firstname": user_data.getFirstName(), "lastname": user_data.getLastName(), "uid": user_data.getUserId(), "age": String(user_data.getAge()), "steps": String(user_data.getStepsGoal()), "calories": String(user_data.getCalories())]
                }
                for document in snapshot!.documents {
                    document.reference.updateData(dictionary)
                    updatedDatabase = true
                }
            }
        }
        if updatedDatabase == false {
            do {
                var dictionary: [String: Any] {
                    return ["firstname": user_data.getFirstName(), "lastname": user_data.getLastName(), "uid": user_data.getUserId(), "age": String(user_data.getAge()), "steps": String(user_data.getStepsGoal()), "calories": String(user_data.getCalories())]
                }
                do {
                    let item = try await db.collection("users").addDocument(data: dictionary)
                    userID = item.documentID
                    print("Data added successfully! ID: ",item.documentID)
                    return true
                } catch {
                    print("Could not create new user profile")
                    return false
                }
                
            }
        }
        return false
    }
    func getUserProfile() {
        let db = Firestore.firestore()
        let query = db.collection("users").whereField("uid", isEqualTo: uid!)
        
        query.getDocuments() { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    if let fname=document.data()["firstname"] as? String {
                        self.user_data.setFirstName(firstName: fname)
                        print("fname in getuserprofile: ",self.user_data.getFirstName())
                    }
                    if let fname=document.data()["lastname"] as? String {
                        self.user_data.setLastName(lastName: fname)
                        print("fname in getuserprofile: ",self.user_data.getLastName())
                    }
                    if let fname=document.data()["age"] as? String {
                        self.user_data.setAge(age: fname)
                        print("fname in getuserprofile: ",self.user_data.getAge())
                    }
                    if let fname=document.data()["steps"] as? String {
                        self.user_data.setStepsGoal(stepsGoal: fname)
                        print("fname in getuserprofile: ",self.user_data.getStepsGoal())
                    }
                    if let fname=document.data()["calories"] as? String {
                        self.user_data.setCalories(calories: fname)
                        print("fname in getuserprofile: ",self.user_data.getCalories())
                    }
                    break
                }
            }
        }
    }
}
