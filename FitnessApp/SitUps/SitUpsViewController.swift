//
//  SitUpsViewController.swift
//  FitnessApp
//
//  Created by Булат Хатмуллин on 18.03.2022.
//
import CoreMotion
import UIKit

class SitUpsViewController: UIViewController {

    @IBOutlet weak var counterLabelSU: UILabel!
    @IBOutlet weak var finishSUButton: UIButton!
    private let sitUpsDataManager = SitUpsDataManager()
    
    @IBOutlet weak var timerLabel: UILabel!
    private var firstSitUp = true
    private var timerForShowing = Timer()
    private var timer = Timer()
    private var count = 0
    private var didSitUpFlag = false
    
    
    let motion = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        finishSUButton.layer.cornerRadius = 5.0
        counterLabelSU.text = "Поверните iPhone"
        timerLabel.isHidden = true
        
    }
    

    override func viewDidAppear(_ animated: Bool)  {
        super.viewDidAppear(animated)
        
        UILabel.animate(withDuration: 2.0, animations: {
            self.counterLabelSU.center = self.view.center
            self.counterLabelSU.transform = CGAffineTransform(rotationAngle: .pi / 2 )
        }){
            _ in self.counterLabelSU.text = "0"
        }
        
        
        UILabel.animate(withDuration: 2.0, animations: {
            self.timerLabel.transform = CGAffineTransform(rotationAngle: .pi / 2 )
        }){
            _ in self.startShowingTimer()
        }
        

        
    }

    
    func startShowingTimer(){
        self.timerLabel.text = "00:00:00"
        self.timerLabel.isHidden = false
        startAccelerometers()

        startTimer()
    }
    
    func startTimer(){

        switch (self.firstSitUp) {
        case false: break
        case true:
            print ("Timer activated")
            self.timerForShowing = Timer.scheduledTimer(timeInterval: 0.1,
                                         target: self,
                                        selector: #selector(self.timeUpdating),
                                         userInfo: nil, repeats: true)
            self.firstSitUp = false
        }
        
    }
    
    func startAccelerometers() {
           if self.motion.isAccelerometerAvailable {
               self.motion.accelerometerUpdateInterval = 1.0/60.0
               self.motion.startAccelerometerUpdates()

              // Configure a timer to fetch the data.
               self.timer = Timer(fire: Date(), interval: (1.0/60.0),
                    repeats: true, block: { (timer) in

                 // Get the accelerometer data.
                 if let data = self.motion.accelerometerData {
                    let z = data.acceleration.z
                     print(z)
                     if z < -1.0 {
                         if self.didSitUpFlag == true{
                             
                             self.printCounterSU()
                             self.didSitUpFlag = false
                             self.pauseAccelerometer()
                         }
                     }
                     if z > 0 {
                         self.didSitUpFlag = true
                     }
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

    func printCounterSU (){
        counterLabelSU?.text = sitUpsDataManager.obtainNumberOfSU()
    }
    
    @objc private func timeUpdating() {
        
        let tensMinutes = String((count / 600) / 10)
        let onesMinutes = String((count / 600) % 10)
        let tensSeconds = String((count / 100) % 6)
        let onesSeconds = String((count / 10) % 10)
        let deciseconds = String((count % 10))

        timerLabel.text = tensMinutes + onesMinutes  + ":" + tensSeconds +
        onesSeconds + ":" + deciseconds + "0"
        count += 1
    }
    
    @IBAction func touchedFinishButton(_ sender: Any) {
        self.timerForShowing.invalidate()

        let alert = UIAlertController(title: "Закончить тренировку?", message: "При согласии ваша тренировка будет окончена", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: {_ in
            self.timer.invalidate()
            let exerciseMinute = (self.count / 600) + ((self.count / 600) % 10)
            let exerciseSeconds = ((self.count / 100) % 6) * 10 + ((self.count / 10) % 10)
            self.sitUpsDataManager.savingResult(didMinutes: exerciseMinute, didSeconds: exerciseSeconds)
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: {_ in
            if (self.firstSitUp == false){
                self.timerForShowing = Timer.scheduledTimer(timeInterval: 0.1,
                                                  target: self, selector: #selector(self.timeUpdating),
                                                  userInfo: nil, repeats: true)
            }
        }))

        self.present(alert, animated: true)
        
    }
    
    
}
