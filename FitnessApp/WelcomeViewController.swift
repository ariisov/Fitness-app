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

    }
    
    func showModalAuth(){
        print("In showModal")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)



    }
    
    
    
    func showMain(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)


        let main = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController

//        self.window?.rootViewController = main
//        self.present(newvc, animated: true)

    }
    
   

}
