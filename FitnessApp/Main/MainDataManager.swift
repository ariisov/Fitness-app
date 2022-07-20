//
//  MainDataManager.swift
//  FitnessApp
//
//  Created by Булат Хатмуллин on 22.05.2022.
//

import Foundation
import Firebase
import FirebaseFirestore

class MainDataManager{
    
    var mainData: [String] = []
    
    func getUserName() -> String! {
        var name = "name"
        let db = Firestore.firestore()
        db.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let userData = document.data()
                    
                    name = userData["name"] as? String ?? ""
                    self.mainData.append(name)
                    let totalNumberOfMinutes = userData["totalMinutes"] as? String ?? ""
                    let totalNumberOfSeconds = userData["totalSeconds"] as? String ?? ""
                    var intNumberOfMinutes = Int(totalNumberOfMinutes) ?? 0
                    let intNumberOfSeconds = Int(totalNumberOfSeconds) ?? 0
                    intNumberOfMinutes = intNumberOfMinutes + (intNumberOfSeconds/60)
                    self.mainData.append(String(intNumberOfMinutes))
                    let totalExercises = userData["totalExercises"] as? String ?? ""
                    self.mainData.append(totalExercises)
                    let totalKcal = userData["totalKcal"] as? String ?? ""
                    self.mainData.append(totalKcal)
                }
            }
        }
        
        return name
    }
    
    
    func getUserTime() -> String! {
        var time = "time"
        let db = Firestore.firestore()
        db.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let userData = document.data()
                    

                    let totalNumberOfMinutes = userData["totalMinutes"] as? String ?? ""
                    let totalNumberOfSeconds = userData["totalSeconds"] as? String ?? ""
                    var intNumberOfMinutes = Int(totalNumberOfMinutes) ?? 0
                    let intNumberOfSeconds = Int(totalNumberOfSeconds) ?? 0
                    intNumberOfMinutes = intNumberOfMinutes + (intNumberOfSeconds/60)
                    time = (String(intNumberOfMinutes))

                }
            }
        }
        
        return time
    }
    
    func getUserExecises() -> String! {
        var exercises = "exercises"
        let db = Firestore.firestore()
        db.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let userData = document.data()
                    
                    exercises = userData["totalExercises"] as? String ?? ""
                }
            }
        }
        
        return exercises
    }
    
    func getUserKcal() -> String! {
        var kcal = "kcal"
        let db = Firestore.firestore()
        db.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let userData = document.data()
                    kcal = userData["totalKcal"] as? String ?? ""
                }
            }
        }
        
        return kcal
    }
}
