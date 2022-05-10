import UIKit
class PushUpsViewController: UIViewController {

    @IBOutlet weak var pushUpsShowButton: UIButton!
    @IBOutlet weak var finishPushUpsButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    private var timer = Timer()
    private var count = 0
    private var datamanager: PushUpsDataManager = PushUpsDataManager()
    private var firstPushUp = true
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finishPushUpsButton.layer.cornerRadius = 5.0
        counterLabel?.text = "0"
    }

    // MARK: Push Up button touched
    @IBAction func touchedPushUpButton(_ sender: Any) {
        counterLabel?.text = datamanager.obtainNumberOfPU()
        switch (firstPushUp) {
        case false: break
        case true:
            timer = Timer.scheduledTimer(timeInterval: 0.1,
                                         target: self,
                                         selector: #selector(timeUpdating),
                                         userInfo: nil, repeats: true)
            firstPushUp = false
        }
    }
    @objc private func timeUpdating() {
        
        let tensMinutes = String((count / 600) / 10)
        let onesMinutes = String((count / 600) % 10)
        let tensSeconds = String((count / 100) % 6)
        let onesSeconds = String((count / 10) % 10)
        let miliseconds = String((count % 10))

        timerLabel.text = tensMinutes + onesMinutes  + ":" + tensSeconds +
        onesSeconds + ":" + miliseconds + "0"
        count += 1
    }
   // MARK: Training finished
    @IBAction func touchedFinishPUButton(_ sender: Any) {
        timer.invalidate()
        let alert = UIAlertController(title: "Закончить тренировку?",
                                      message: "При согласии ваша тренировка будет окончена",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: {_ in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: {
            action in
            if (self.firstPushUp == false){
                self.timer = Timer.scheduledTimer(timeInterval: 0.1,
                                                  target: self, selector: #selector(self.timeUpdating),
                                                  userInfo: nil, repeats: true)
            }
        }))
        self.present(alert, animated: true)
    }
}






