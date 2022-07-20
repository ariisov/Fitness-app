//
//  SitUpsPrepareViewController.swift
//  FitnessApp
//
//  Created by Булат Хатмуллин on 18.03.2022.
//

import UIKit

class SitUpsPrepareViewController: UIViewController {

    
    @IBOutlet weak var startSitUpsButton: UIButton!
    
    @IBOutlet weak var descriptionText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        startSitUpsButton.layer.cornerRadius = 5.0
        
        self.title = "Важная информация"
        
        descriptionText.text = "Держите руками телефон так, чтобы при поднимании корпуса экран смотрел к вам лицом.\r\n Повторение считается выполненным если экран телефона будет смотреть ровно вверх.\r\n Исходное положение - лёжа на спине. Поднимайтесь в вертикальное положения используя мышцы пресса."
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
