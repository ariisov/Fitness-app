//
//  PUDataManager.swift
//  FitnessApp
//
//  Created by Булат Хатмуллин on 19.03.2022.
//

import Foundation
import Firebase
import FirebaseFirestore

class PushUpsDataManager {
    
    var counterNumberOfPU = 0

    
    func obtainNumberOfPU() -> String? {
        counterNumberOfPU += 1
        return String(counterNumberOfPU)
    }
    
    func zeroingNumberOfPU(){
        counterNumberOfPU = 0
    }
    
    func savingResult(didMinutes: Int, didSeconds: Int) {
        var dataNumberOfMinutes = 0
        var dataNumberOfSeconds = 0
        var dataNumberOfExercises = 0

        let db = Firestore.firestore()
        db.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let myData = document.data()
                    let totalNumberOfMinutes = myData["totalMinutes"] as? String ?? ""
                    let totalNumberOfSeconds = myData["totalSeconds"] as? String ?? ""
                    dataNumberOfMinutes = Int(totalNumberOfMinutes) ?? 0
                    dataNumberOfSeconds = Int(totalNumberOfSeconds) ?? 0
                    let totalNumberOfExercises = myData["totalExercises"] as? String ?? ""
                    dataNumberOfExercises = Int(totalNumberOfExercises) ?? 0
                    
                    
                    db.collection("users").document("ew7b93fBMEMf0sLmqRV5").updateData([
                        "totalMinutes": String(didMinutes + dataNumberOfMinutes),
                        "totalSeconds": String(didSeconds + dataNumberOfSeconds),
                        "totalExercises": String(dataNumberOfExercises + 1)
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
