//
//  SUDataManager.swift
//  FitnessApp
//
//  Created by Булат Хатмуллин on 19.03.2022.
//

import Foundation
import Firebase
import FirebaseFirestore

class SitUpsDataManager {
    private var count = 0

    private var counterNumberOfSU = 0

    func obtainNumberOfSU() -> String {
        counterNumberOfSU += 1
        return String(counterNumberOfSU)
    }
    
    func savingResult(didMinutes: Int, didSeconds: Int) {
        let db = Firestore.firestore()
        db.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let myData = document.data()
                    let totalNumberOfMinutes = myData["totalMinutes"] as? String ?? ""
                    let totalNumberOfSeconds = myData["totalSeconds"] as? String ?? ""
                    let dataNumberOfMinutes = Int(totalNumberOfMinutes) ?? 0
                    let dataNumberOfSeconds = Int(totalNumberOfSeconds) ?? 0
                    let totalNumberOfExercises = myData["totalExercises"] as? String ?? ""
                    let dataNumberOfExercises = Int(totalNumberOfExercises) ?? 0
                    let totalNumberOfKcal = myData["totalKcal"] as? String ?? ""
                    let dataNumberOfKcal = Int(totalNumberOfKcal) ?? 0
                    
                    db.collection("users").document(Auth.auth().currentUser!.uid).updateData([
                        "totalMinutes": String(didMinutes + dataNumberOfMinutes),
                        "totalSeconds": String(didSeconds + dataNumberOfSeconds),
                        "totalExercises": String(dataNumberOfExercises + 1),
                        "totalKcal": String(dataNumberOfKcal + self.counterNumberOfSU*2),
                        
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document successfully updated")
                        }
                    }
                }
            }
        }
        
        
    }
    
    
}

