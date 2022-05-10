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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startPullUpsButton.layer.cornerRadius = 5.0
    }
}
