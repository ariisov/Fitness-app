//
//  PullUpsPrepareViewController.swift
//  FitnessApp
//
//  Created by Булат Хатмуллин on 01.05.2022.
//

import Foundation
import UIKit

class PullUpsPrepareViewController: UIViewController {

    @IBOutlet weak var startPullUpsButton: UIButton!
    
    @IBOutlet weak var descriptionText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        startPullUpsButton.layer.cornerRadius = 5.0
        
        self.title = "Важная информация"
        
        descriptionText.text = "Положите телефон в карман.\r\n Исходное положение держитесь за турник без опоры снизу. Поднимайтесь, сгибая руки в локтях без раскачиваний."
    }
}
