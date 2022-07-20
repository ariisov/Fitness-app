//
//  SquatsPrepareViewController.swift
//  FitnessApp
//
//  Created by Булат Хатмуллин on 01.05.2022.
//

import Foundation

import UIKit

class SquatsPrepareViewController: UIViewController {
    
    
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var startSquatsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startSquatsButton.layer.cornerRadius = 5.0

        
        self.title = "Важная информация"
        
        descriptionText.text = "Держите руками телефон так, чтобы экран смотрел к вам лицом.\r\n Исходное положение: ноги на ширине плеч, стопы развернуты на 5-30 градусов.\r\n В нижней точке приседа необходимо задержаться, чтобы тело не использовало инерцию для возвращения в исходное положение"
    }
    
}
