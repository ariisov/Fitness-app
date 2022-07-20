//
//  MainViewController.swift
//  FitnessApp
//
//  Created by Булат Хатмуллин on 17.03.2022.
//

import UIKit
import Firebase
import FirebaseFirestore

class MainViewController: UIViewController {

    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var spacerView: UIView!
    @IBOutlet weak var buttonGoPushUps: UIButton!
    @IBOutlet weak var buttonGoSitUps: UIButton!
    @IBOutlet weak var buttonGoSquats: UIButton!
    @IBOutlet weak var buttonGoPullUps: UIButton!

    @IBOutlet weak var labelTotalNumberOfKcal: UILabel!
    @IBOutlet weak var labelTotalNumberOfMinutes: UILabel!
    @IBOutlet weak var labelTotalNumberOfExercises: UILabel!
    @IBOutlet weak var trainsLabel: UILabel!
    
    private var didSetData = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.spacerView.backgroundColor = UIColor.white
        
        let buttons: [UIButton] = [buttonGoPushUps,
                                   buttonGoSitUps,
                                   buttonGoSquats,
                                   buttonGoPullUps]
        for button in buttons {
            button.layer.cornerRadius = 20.0
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 2, height: 2)
            button.layer.shadowRadius = 5
            button.layer.shadowOpacity = 0.3
        }
        
        self.greetingLabel.isHidden = false

//        let name = dataManager.getUserName()
//        self.greetingLabel.text = "Привет, \(name)!"
//        let totalMinutes = dataManager.getUserTime()
//        self.labelTotalNumberOfMinutes.text = totalMinutes
//        let totalExercises = dataManager.getUserExecises()
//        self.labelTotalNumberOfExercises.text = totalExercises
//        let totalKcal = dataManager.getUserKcal()
//        self.labelTotalNumberOfKcal.text = totalKcal
        
        let db = Firestore.firestore()
        db.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let userData = document.data()
                    
                    let name = userData["name"] as? String ?? ""
                    self.greetingLabel.text = "Привет, \(name)!"
                    let totalNumberOfMinutes = userData["totalMinutes"] as? String ?? ""
                    let totalNumberOfSeconds = userData["totalSeconds"] as? String ?? ""
                    var intNumberOfMinutes = Int(totalNumberOfMinutes) ?? 0
                    let intNumberOfSeconds = Int(totalNumberOfSeconds) ?? 0
                    intNumberOfMinutes = intNumberOfMinutes + (intNumberOfSeconds/60)
                    self.labelTotalNumberOfMinutes.text = String(intNumberOfMinutes)
                    let totalExercises = userData["totalExercises"] as? String ?? ""
                    self.labelTotalNumberOfExercises.text = totalExercises
                    let totalKcal = userData["totalKcal"] as? String ?? ""
                    self.labelTotalNumberOfKcal.text = totalKcal
                }
            }
        }
        
        
        didSetData = true
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !didSetData{
            setHeadData()
        }
        
    }
    

    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        didSetData = false
    }

    
    func setHeadData(){
        
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

                    self.labelTotalNumberOfMinutes.text = String(intNumberOfMinutes)
                    
                    self.labelTotalNumberOfKcal.text = userData["totalKcal"] as? String ?? ""
                    
                    self.labelTotalNumberOfExercises.text = userData["totalExercises"] as? String ?? ""
                }
            }
        }
        
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()

        } catch {
            print(error)
        }
    }
    
}
