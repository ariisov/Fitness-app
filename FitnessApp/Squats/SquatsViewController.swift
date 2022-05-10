//
//  SquatsViewController.swift
//  FitnessApp
//
//  Created by Булат Хатмуллин on 01.05.2022.
//

import Foundation
import UIKit
import CoreMotion

class SquatsViewController: UIViewController {
    @IBOutlet weak var finishSquatsButton: UIButton!
    
    
    @IBOutlet weak var counterLabelSquats: UILabel!
    
    let motion = CMMotionManager()
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabelSquats.text = "Поверните iPhone"
        finishSquatsButton.layer.cornerRadius = 5.0
    }
    
    override func viewDidAppear(_ animated: Bool)  {
        super.viewDidAppear(animated)
        
        
        UILabel.animate(withDuration: 2.0, animations: {
            self.counterLabelSquats.center = self.view.center
            self.counterLabelSquats.transform = CGAffineTransform(rotationAngle: .pi / 2 )
            self.counterLabelSquats.text = "0"
        }){
            _ in self.startAccelerometers()
        }
        
        

    }
    
    func startAccelerometers() {
       // Make sure the accelerometer hardware is available.
       if self.motion.isAccelerometerAvailable {
          self.motion.accelerometerUpdateInterval = 1.0
          self.motion.startAccelerometerUpdates()

          // Configure a timer to fetch the data.
          self.timer = Timer(fire: Date(), interval: (1.0/60.0),
                repeats: true, block: { (timer) in
             // Get the accelerometer data.
             if let data = self.motion.accelerometerData {
                let x = data.acceleration.x
                 
                 print(x)
             }
          })

          // Add the timer to the current run loop.
           RunLoop.current.add(self.timer, forMode: .default )
       }
    }
    
    
    
    // MARK: Training finished
     @IBAction func touchedFinishSquatsButton(_ sender: Any) {
         let alert = UIAlertController(title: "Закончить тренировку?",
                                       message: "При согласии ваша тренировка будет окончена",
                                       preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "Да", style: .default, handler: {_ in
             self.timer.invalidate()
             self.navigationController?.popToRootViewController(animated: true)
         }))
         
         alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
         self.present(alert, animated: true)
     }
}
