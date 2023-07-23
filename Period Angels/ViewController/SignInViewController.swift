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
   
    @IBOutlet weak var skipBtn: UIButton!
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var reset: UILabel!
    @IBOutlet weak var continueBtn: UIButton!
    
    @IBOutlet weak var registerBtn: UILabel!
    
    override func viewDidLoad() {
        
        emailTF.delegate = self
        emailTF.changePlaceholderColour()
        passwordTF.delegate = self
        passwordTF.changePlaceholderColour()
        emailTF.setLeftPaddingPoints(10)
        emailTF.setRightPaddingPoints(10)
        
        passwordTF.setLeftPaddingPoints(10)
        passwordTF.setRightPaddingPoints(10)
        
        emailTF.addBorder()
        passwordTF.addBorder()
        
        continueBtn.layer.cornerRadius = 8
        
        registerBtn.isUserInteractionEnabled = true
        registerBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(registerBtnClicked)))
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        var date = DateComponents()
        date.year = 2023
        date.month = 02
        date.day = 1
        date.timeZone = TimeZone(abbreviation: "IST")
        date.hour = 8
        date.minute = 59
        date.second = 55
        let userCalendar = Calendar.current

        let currentDate = Date()
        if let futureDateAndTime = userCalendar.date(from: date) {
            if futureDateAndTime > currentDate {
                self.skipBtn.isHidden = false

            }
            else {
                self.skipBtn.isHidden = true

            }
        }
        
        skipBtn.layer.cornerRadius = 8
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
    
    @IBAction func skipBtnClicked(_ sender: Any) {
        
        self.beRootScreen(mIdentifier: Constants.StroyBoard.tabBarViewController)
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
