//
//  MainViewController.swift
//  FitnessApp
//
//  Created by Булат Хатмуллин on 17.03.2022.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var spacerView: UIView!
    @IBOutlet weak var buttonGoPushUps: UIButton!
    @IBOutlet weak var buttonGoSitUps: UIButton!
    @IBOutlet weak var buttonGoSquats: UIButton!
    @IBOutlet weak var buttonGoPullUps: UIButton!


    @IBOutlet weak var labelTotalNumberOfExercises: UILabel!
    @IBOutlet weak var labelTotalNumberOfMinutes: UILabel!
    @IBOutlet weak var totalNumberOfCcals: UILabel!
    @IBOutlet weak var trainsLabel: UILabel!
    
    var circularprogress = CircularView(frame: CGRect(x: 0, y: 0, width: 108, height: 108))

    var radiusCorners = 30.0
    
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
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        circularprogress.percent = 13.0
//        circularprogress.lineColor = UIColor.blue
//        circularprogress.backgroundLineWidth = 20.0
//        circularprogress.lineWidth = 20.0
//        circularprogress.animateCircle(duration: 0.1)

        
        
        
        
        
    }
    
    
    @IBAction func touchedPUButton(_ sender: Any) {
        
    }
    

}
