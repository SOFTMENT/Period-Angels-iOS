//
//  SignInViewController.swift
//  Period Angels
//
//  Created by Vijay Rathore on 25/12/22.
//

import UIKit
import Firebase
import FirebaseAuth


class SignInViewController : UIViewController {
   
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var reset: UILabel!
    @IBOutlet weak var continueBtn: UIButton!
    
    @IBOutlet weak var registerBtn: UILabel!
    
    override func viewDidLoad() {
        
        emailTF.delegate = self
        passwordTF.delegate = self
        
        continueBtn.layer.cornerRadius = 8
        
        registerBtn.isUserInteractionEnabled = true
        registerBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(registerBtnClicked)))
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
    }
    
    @objc func registerBtnClicked(){
        performSegue(withIdentifier: "signUpSeg", sender: nil)
    }
    
    @objc func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    @IBAction func continueBtnClicked(_ sender: Any) {
        let sEmail = emailTF.text?.trimmingCharacters(in: .nonBaseCharacters)
        let sPassword = passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if sEmail == "" {
            showSnack(messages: "Enter Email Address")
        }
        else if sPassword == "" {
            showSnack(messages: "Enter Password")
        }
        else {
            ProgressHUDShow(text: "")
            Auth.auth().signIn(withEmail: sEmail!, password: sPassword!) { authResult, error in
                self.ProgressHUDHide()
                if error == nil {
                 
                    self.continueToLogin(uid: Auth.auth().currentUser!.uid)
        
                }
                else {
                    self.showError(error!.localizedDescription)
                }
            }
        }

    }
    @objc func forgotPasswordClicked() {
        let sEmail = emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if sEmail == "" {
            showSnack(messages: "Enter Email Address")
        }
        else {
            ProgressHUDShow(text: "")
            Auth.auth().sendPasswordReset(withEmail: sEmail!) { error in
                self.ProgressHUDHide()
                if error == nil {
                    self.showMessage(title: "RESET PASSWORD", message: "We have sent reset password link on your mail address.", shouldDismiss: false)
                }
                else {
                    self.showError(error!.localizedDescription)
                }
            }
        }
    }
}

extension SignInViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
