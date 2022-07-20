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
    private let squatsDataManager = SquatsDataManager()
    private var firstSquat = true
    private var timerForShowing = Timer()
    private var count = 0
    private var didSquatFlag = false


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
            _ in self.startShowingTimer()
        }
        
        

    }
    
    func startShowingTimer(){

        startAccelerometers()

        startTimer()
    }
    
    func startTimer(){

        switch (self.firstSquat) {
        case false: break
        case true:
            print ("Timer activated")
            self.timerForShowing = Timer.scheduledTimer(timeInterval: 0.1,
                                         target: self,
                                        selector: #selector(self.timeUpdating),
                                         userInfo: nil, repeats: true)
            self.firstSquat = false
        }
        
    }

    @objc private func timeUpdating() {

        count += 1
    }
    
    func startAccelerometers() {
       // Make sure the accelerometer hardware is available.
       if self.motion.isAccelerometerAvailable {
          self.motion.accelerometerUpdateInterval = 0.1
          self.motion.startAccelerometerUpdates()

          // Configure a timer to fetch the data.
          self.timer = Timer(fire: Date(), interval: (1.0/60.0),
                repeats: true, block: { (timer) in
             // Get the accelerometer data.
             if let data = self.motion.accelerometerData {
                let x = data.acceleration.x
                 if x < 0.0 {
                     if self.didSquatFlag == true{
                         
                         self.printCounterSquats()
                         self.didSquatFlag = false
                         self.pauseAccelerometer()
                     }
                 }
                 if x > 0 {
                     self.didSquatFlag = true
                 }
                 print(x)
             }
          })

          // Add the timer to the current run loop.
           RunLoop.current.add(self.timer, forMode: .default )
       }
    }
    
    func pauseAccelerometer(){
        timer.invalidate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.startAccelerometers()
        }
    }

    func printCounterSquats (){
        counterLabelSquats?.text = squatsDataManager.obtainNumberOfSquats()
    }
    
    // MARK: Training finished
     @IBAction func touchedFinishSquatsButton(_ sender: Any) {
         let alert = UIAlertController(title: "Закончить тренировку?",
                                       message: "При согласии ваша тренировка будет окончена",
                                       preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "Да", style: .default, handler: {_ in
             self.timer.invalidate()
             let exerciseMinute = (self.count / 600) + ((self.count / 600) % 10)
             let exerciseSeconds = ((self.count / 100) % 6) * 10 + ((self.count / 10) % 10)
             self.squatsDataManager.savingResult(didMinutes: exerciseMinute, didSeconds: exerciseSeconds)
             self.navigationController?.popToRootViewController(animated: true)
         }))
         
         alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
         self.present(alert, animated: true)
     }
}
