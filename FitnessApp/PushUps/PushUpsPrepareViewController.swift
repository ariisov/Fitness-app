//
//  PushUpsPrepareViewController.swift
//  FitnessApp
//
//  Created by Булат Хатмуллин on 18.03.2022.
//

import UIKit

class PushUpsPrepareViewController: UIViewController {

 
    
    @IBOutlet weak var NavigationBarItem: UINavigationItem!


    @IBOutlet weak var startTrainingButton: UIButton!
    
    
    @IBOutlet weak var descriptionText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NavigationBarItem.hidesBackButton = UIColor(red: 255, green: 151, blue: 0, alpha: 1)
        startTrainingButton.layer.cornerRadius = 5.0
        NavigationBarItem.backBarButtonItem?.tintColor = UIColor(red: 255, green: 151, blue: 0, alpha: 1)
        
        title = "Важная информация"
        
        descriptionText.text = " Положите телефон так, чтобы при сгибании рук, можно было коснуться экрана кончиком носа. \r\n Повторение считается выполненным, если вы коснетесь экрана.\r\n В исходном положении руки выпрямлены и удерживают вес всего тела. Аккуратно, сохраняя прямое положение тела, постепенно опускайтесь грудью к полу, сгибая локти."
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
