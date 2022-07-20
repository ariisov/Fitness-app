//
//  PullUpsViewController.swift
//  FitnessApp
//
//  Created by Булат Хатмуллин on 01.05.2022.
//

import Foundation
import UIKit
import CoreMotion


class PullUpsViewController: UIViewController {

    @IBOutlet weak var finishPullUpsButton: UIButton!
    @IBOutlet weak var counterLabel: UILabel!
    private var timer = Timer()
    let motion = CMMotionManager()
    
    private var firstPullUp = true
    private var timerForShowing = Timer()
    private var count = 0

    private var didPullUpFlag = false

    private let pullUpsDataManager = PullUpsDataManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        finishPullUpsButton.layer.cornerRadius = 5.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        startShowingTimer()

    }

    
    func startShowingTimer(){

        startAccelerometers()

        startTimer()
    }
    
    func startTimer(){

        switch (self.firstPullUp) {
        case false: break
        case true:
            print ("Timer activated")
            self.timerForShowing = Timer.scheduledTimer(timeInterval: 0.1,
                                         target: self,
                                        selector: #selector(self.timeUpdating),
                                         userInfo: nil, repeats: true)
            self.firstPullUp = false
        }
        
    }

    @objc private func timeUpdating() {

        count += 1
    }
    
    
    func startAccelerometers() {
       // Make sure the accelerometer hardware is available.
       if self.motion.isAccelerometerAvailable {
          self.motion.accelerometerUpdateInterval = 1.0 / 60.0  // 60 Hz
          self.motion.startAccelerometerUpdates()

          // Configure a timer to fetch the data.
          self.timer = Timer(fire: Date(), interval: (1.0/60.0),
                repeats: true, block: { (timer) in
             // Get the accelerometer data.
             if let data = self.motion.accelerometerData {
                let y = data.acceleration.y
                 
                 print(y)
                 if y < 0.0 {
                     if self.didPullUpFlag == true{
                         self.printCounterPU()
                         self.didPullUpFlag = false
                         self.pauseAccelerometer()
                     }
                 }
                 if y > 0 {
                     self.didPullUpFlag = true
                 }
                // Use the accelerometer data in your app.
             }
          })

          // Add the timer to the current run loop.
           RunLoop.current.add(self.timer, forMode: .default)
       }
    }
    
    func pauseAccelerometer(){
        timer.invalidate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.startAccelerometers()
        }
    }

    func printCounterPU (){
        counterLabel?.text = pullUpsDataManager.obtainNumberOfPullUps()
    }
    
    
    // MARK: Training finished
     @IBAction func touchedFinishPullUpsButton(_ sender: Any) {
         
         let alert = UIAlertController(title: "Закончить тренировку?", message: "При согласии ваша тренировка будет окончена", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "Да", style: .default, handler: {_ in
             self.timer.invalidate()
             let exerciseMinute = (self.count / 600) + ((self.count / 600) % 10)
             let exerciseSeconds = ((self.count / 100) % 6) * 10 + ((self.count / 10) % 10)
             self.pullUpsDataManager.savingResult(didMinutes: exerciseMinute, didSeconds: exerciseSeconds)
             self.navigationController?.popToRootViewController(animated: true)
         }))
         
         alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: {_ in
             
             alert.userActivity?.invalidate()
             }
         ))

         self.present(alert, animated: true)
     }
}
