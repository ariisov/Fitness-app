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
    var counterSU = 0
    
    var timer = Timer()
    var count = 0
    
    let motion = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabelSU.text = "Поверните iPhone"
    }
    

    override func viewDidAppear(_ animated: Bool)  {
        super.viewDidAppear(animated)
        
        UILabel.animate(withDuration: 2.0, animations: {
            self.counterLabelSU.center = self.view.center
            self.counterLabelSU.transform = CGAffineTransform(rotationAngle: .pi / 2 )

        }){
            _ in self.counterLabelSU.text = "0"
        }

    }

    func startGyros() {
        DispatchQueue.global(qos: .userInteractive).async {
            if self.motion.isGyroAvailable {
                self.motion.gyroUpdateInterval = 0.1
                self.motion.startGyroUpdates(to: OperationQueue.current!) {
                    (data, error) in
                    if let currentData = data {
                        if currentData.rotationRate.y > 2 {
                            DispatchQueue.main.async {
                                self.printCounterSU()
                            }
                            sleep(1)
                        }
                    }
               }
            }
        }
       
    }

    func printCounterSU (){
        self.counterSU += 1
        self.counterLabelSU.text = String(self.counterSU)
    }
    
    @IBAction func touchedFinishButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Закончить тренировку?", message: "При согласии ваша тренировка будет окончена", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: {_ in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))

        self.present(alert, animated: true)
        
    }
    
    
}
