//
//  SquatsViewController.swift
//  FitnessApp
//
//  Created by Булат Хатмуллин on 01.05.2022.
//

import Foundation
import UIKit

class SquatsViewController: UIViewController {
    @IBOutlet weak var finishSquatsButton: UIButton!
    
    // MARK: Training finished
     @IBAction func touchedFinishSquatsButton(_ sender: Any) {
         let alert = UIAlertController(title: "Закончить тренировку?",
                                       message: "При согласии ваша тренировка будет окончена",
                                       preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "Да", style: .default, handler: {_ in
             self.navigationController?.popToRootViewController(animated: true)
         }))
         
         alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
         self.present(alert, animated: true)
     }
}
