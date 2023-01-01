//
//  SignUpViewController.swift
//  Period Angels
//
//  Created by Vijay Rathore on 25/12/22.
//

import UIKit
import Firebase

class SignUpViewController : UIViewController {
    
    

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UILabel!
    
    override func viewDidLoad() {
        
        emailTF.delegate = self
        emailTF.changePlaceholderColour()
        passwordTF.delegate = self
        passwordTF.changePlaceholderColour()
        nameTF.delegate = self
        nameTF.changePlaceholderColour()
        
        registerBtn.layer.cornerRadius = 8
        
        loginBtn.isUserInteractionEnabled = true
        loginBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginBtnClicked)))
        
        backView.isUserInteractionEnabled = true
        backView.layer.cornerRadius = 8
        backView.dropShadow()
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginBtnClicked)))
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
    }
    
    @objc func loginBtnClicked(){
        self.dismiss(animated: true)
    }
    
    @objc func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    @IBAction func registerBtnClicked(_ sender: Any) {
        
        let sFullName = nameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let sEmail = emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let sPassword = passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if sFullName == "" {
            showSnack(messages: "Enter Full Name")
        }
        else if sEmail == "" {
            showSnack(messages: "Enter Email")
        }
        else if sPassword  == "" {
            showSnack(messages: "Enter Password")
        }
        else {
            ProgressHUDShow(text: "Creating Account...")
            Auth.auth().createUser(withEmail: sEmail!, password: sPassword!) { result, error in
                self.ProgressHUDHide()
                if error == nil {
                    let userData = UserModel()
                    userData.fullName = sFullName
                    userData.email = sEmail
                    userData.uid = Auth.auth().currentUser!.uid
                    userData.registredAt = Date()
                    userData.regiType = "custom"
                    self.addUserData(userData: userData)
                
                }
                else {
                    self.showError(error!.localizedDescription)
                }
            }
        }
        
    }
}

extension SignUpViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
