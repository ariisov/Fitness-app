//
//  AuthViewController.swift
//  FitnessApp
//
//  Created by Булат Хатмуллин on 07.05.2022.
//

import UIKit
import Firebase
import FirebaseFirestore

class AuthViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var enterButton: UIButton!
    private var signup: Bool = true{
        willSet{
            if newValue{
                titleLabel.text = "Регистрация"
                nameTextField.isHidden = false
                questionLabel.text = "У вас уже есть учетная запись?"
                enterButton.setTitle("Войти в аккаунт", for: .normal)
            }else{
                titleLabel.text = "Вход"
                nameTextField.isHidden = true
                questionLabel.text = "У вас еще нет аккаунта?"
                enterButton.setTitle("Регистрация", for: .normal)

            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    

    @IBAction func switchLogin(_ sender: Any) {
        signup = !signup
    }
    
    func showAlert(){
        
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension AuthViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let name = nameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if signup {
            if (!name.isEmpty && !email.isEmpty && !password.isEmpty){
                Auth.auth().createUser(withEmail: email, password: password) {
                    result, error in
                    if error == nil{
                        if let result = result{
                            let db = Firestore.firestore()
                            db.collection("users").document(result.user.uid).setData([
                                "uid": result.user.uid,
                                "name": name,
                                "totalKcal": "0",
                                "totalExercises": "0",
                                "totalMinutes": "0",
                                "totalSeconds": "0"
                            ]) { error in
                                if error != nil {
                                    fatalError("Error saving user in database")
                                }
                            }
                            
                            
                            self.dismiss(animated: true)
                        }
                    }
                }
            }else{
                showAlert()
            }
            
        }else{
            if (!email.isEmpty && !password.isEmpty){
                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    if error == nil{
                        self.dismiss(animated: true)
                    }
                }
            }
            else{
                showAlert()
            }
        }
        return true
    }
}
