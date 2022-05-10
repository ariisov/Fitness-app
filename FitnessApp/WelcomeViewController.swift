//
//  WelcomeViewController.swift
//  FitnessApp
//
//  Created by Булат Хатмуллин on 07.05.2022.
//

import UIKit
import Firebase


class WelcomeViewController: UIViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
//        Auth.auth().addStateDidChangeListener { auth, user in
//            if (user != nil) {
//                print("In auth")
//                self.showModalAuth()
//                print("In auth 2")
//            }
//            else {
//                self.showMain()
//            }
//        }
//        
//        navigationController?.popToRootViewController(animated: true)
//        
    }
    
    func showModalAuth(){
        print("In showModal")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)


        let authViewController = storyboard.instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController

//        self.present(newvc, animated: true)
        
        
        
        
        
    }
    
    
    
    func showMain(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)


        let main = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController

//        self.window?.rootViewController = main
//        self.present(newvc, animated: true)

    }
    
   

}
