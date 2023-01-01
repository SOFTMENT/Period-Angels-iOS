//
//  ManageProductsViewController.swift
//  Period Angels
//
//  Created by Vijay Rathore on 31/12/22.
//

import UIKit
import Firebase

class ManageProductsViewController : UIViewController {
    
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var periodPadsTF: UITextField!
    
    @IBOutlet weak var tamponsTF: UITextField!
    
    @IBOutlet weak var enterQuantityView: UIView!
    
    
    @IBOutlet weak var reusableTF: UITextField!
    
    @IBOutlet weak var menstrualCupsTF: UITextField!
    
    @IBOutlet weak var plasticFreeTF: UITextField!
    
    @IBOutlet weak var saveBtn: UIButton!
    override func viewDidLoad() {
        
        backView.isUserInteractionEnabled = true
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtnClicked)))
        backView.layer.cornerRadius = 8
        backView.dropShadow()
        
        periodPadsTF.delegate = self
        tamponsTF.delegate = self
        reusableTF.delegate = self
        menstrualCupsTF.delegate = self
        plasticFreeTF.delegate = self
        
        saveBtn.layer.cornerRadius = 8
        
        enterQuantityView.layer.cornerRadius = 8
        
        
        
    }
    
    @objc func backBtnClicked(){
        self.dismiss(animated: true)
    }
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        let sPads = periodPadsTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let sTampons = tamponsTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let sReusable = reusableTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let sMenstrual = menstrualCupsTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let sPlastic = plasticFreeTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if sPads == "" {
            self.showSnack(messages: "Enter Period Pads Quantity")
        }
        else if sTampons == "" {
            self.showSnack(messages: "Enter Tampons Quantity")
        }
        else if sReusable == "" {
            self.showSnack(messages: "Enter Reusable Products Quantity")
        }
        else if sMenstrual == "" {
            self.showSnack(messages: "Enter Menstrual Cups Quantity")
        }
        else if sPlastic == "" {
            self.showSnack(messages: "Enter Platic Free Quantity")
        }
        else {
            ProgressHUDShow(text: "")
            let volunteerModel = VolunteerModel()
            volunteerModel.periodPads = Int(sPads!)
            volunteerModel.tampons = Int(sTampons!)
            volunteerModel.reusableProducts = Int(sReusable!)
            volunteerModel.menstrualCup = Int(sMenstrual!)
            volunteerModel.plasticFree = Int(sPlastic!)
            try? Firestore.firestore().collection("Volunteers")
                .document(Auth.auth().currentUser!.uid).setData(from: volunteerModel, merge: true,completion: { error in
                    self.ProgressHUDHide()
                    if let error = error {
                        self.showError(error.localizedDescription)
                    }
                    else {
                        self.showSnack(messages: "Saved")
                    }
                })
        }
        
        
    }
    
    
}


extension ManageProductsViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismiss(animated: true)
        return true
    }
}
