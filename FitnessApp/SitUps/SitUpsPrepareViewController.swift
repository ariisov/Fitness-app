//
//  SitUpsPrepareViewController.swift
//  FitnessApp
//
//  Created by Булат Хатмуллин on 18.03.2022.
//

import UIKit

class SitUpsPrepareViewController: UIViewController {

    
    @IBOutlet weak var startSitUpsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startSitUpsButton.layer.cornerRadius = 5.0
        
        self.title = "Важная информация"
        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
