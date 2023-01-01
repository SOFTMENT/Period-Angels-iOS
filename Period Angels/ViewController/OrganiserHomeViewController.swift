//
//  OrganiserHomeViewController.swift
//  Period Angels
//
//  Created by Vijay Rathore on 25/12/22.
//

import UIKit
import Firebase

class OrganiserHomeViewController : UIViewController {
    
    @IBOutlet weak var organisationName: UILabel!
    @IBOutlet weak var organisationPhoneNumber: UILabel!
    @IBOutlet weak var organisationAddress: UILabel!
    @IBOutlet weak var businessTypeView: UIView!
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var settingsView: UIView!
    
    @IBOutlet weak var padsView: UIView!
    @IBOutlet weak var tamponsView: UIView!
    
    @IBOutlet weak var cupView: UIView!
    @IBOutlet weak var plasticView: UIView!
    
    @IBOutlet weak var reusableView: UIView!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var periodPadsCheck: UIButton!
    @IBOutlet weak var tamponsCheck: UIButton!

    @IBOutlet weak var cupCheck: UIButton!
    
    
    @IBOutlet weak var plasticCheck: UIButton!
    
    @IBOutlet weak var reusableCheck: UIButton!
    
    
    
    override func viewDidLoad() {
        
        padsView.layer.cornerRadius = padsView.layer.bounds.height / 2
        tamponsView.layer.cornerRadius = padsView.layer.bounds.height / 2
        cupView.layer.cornerRadius = padsView.layer.bounds.height / 2
        plasticView.layer.cornerRadius = padsView.layer.bounds.height / 2
        reusableView.layer.cornerRadius = padsView.layer.bounds.height / 2
        
        settingsView.isUserInteractionEnabled = true
        settingsView.layer.cornerRadius = 8
        settingsView.dropShadow()
        settingsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(settingsViewClicked)))
        
        businessTypeView.layer.cornerRadius = 8
        businessTypeView.dropShadow()
        
        saveBtn.layer.cornerRadius = 8
        
        
        loadUI(organisationModel: OrganiserModel.data!)
    }
    
    
    @IBAction func padsClicked(_ sender: Any) {
        periodPadsCheck.isSelected = !periodPadsCheck.isSelected
    }
    
    @IBAction func tamponsClicked(_ sender: Any) {
        tamponsCheck.isSelected = !tamponsCheck.isSelected
    }
    
    @IBAction func cupClicked(_ sender: Any) {
        cupCheck.isSelected = !cupCheck.isSelected
    }
    @IBAction func plasticFreeClicked(_ sender: Any) {
        plasticCheck.isSelected = !plasticCheck.isSelected
    }
    
    @IBAction func reusableClicked(_ sender: Any) {
        reusableCheck.isSelected = !reusableCheck.isSelected
    }
    
    
    @objc func settingsViewClicked(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Manage Opening Times", style: .default,handler: { action in
            self.performSegue(withIdentifier: "manageAvailableSeg", sender: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Go to User", style: .default,handler: { action in
            UserDefaults().set("user", forKey: "userType")
            self.getUserData(uid: Auth.auth().currentUser!.uid, showProgress: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Go to Volunteer", style: .default,handler: { action in
            UserDefaults().set("volunteer", forKey: "userType")
            if let isVolunteer = UserModel.data!.volunteer, isVolunteer {
                self.getVolunteerData(uid: Auth.auth().currentUser!.uid, showProgress: true)
            }
            else {
                self.beRootScreen(mIdentifier: Constants.StroyBoard.setupVolunteerController)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Logout", style: .default,handler: { action in
            let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Logout", style: .default,handler: { action in
                
                UserDefaults().set("", forKey: "userType")
                self.logout()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(alert, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    func loadUI(organisationModel : OrganiserModel){
        
        periodPadsCheck.isSelected = true
        tamponsCheck.isSelected = true
        cupCheck.isSelected = true
        plasticCheck.isSelected = true
        reusableCheck.isSelected = true
        
        organisationName.text = organisationModel.name ?? "Name"
        organisationPhoneNumber.text = organisationModel.phoneNumber ?? "Phone"
        organisationAddress.text = organisationModel.fullAddress ?? "Address"
        
        if organisationModel.type!.elementsEqual("public") {
            businessName.text  = "Public"
            typeImage.image = UIImage(named: "building")
        }
        else if organisationModel.type!.elementsEqual("business") {
            businessName.text  = "Business"
            typeImage.image = UIImage(named: "shop")
        }
        else if organisationModel.type!.elementsEqual("charity") {
            businessName.text  = "Charity"
            typeImage.image = UIImage(named: "charity")
        }
        else if organisationModel.type!.elementsEqual("other") {
            businessName.text  = "Other"
            typeImage.image = UIImage(named: "other")
        }
        
        if let products = organisationModel.products {
            for product in products {
                if product.elementsEqual("tampons") {
                    self.tamponsCheck.isSelected = true
                }
                if product.elementsEqual("menstrual") {
                    self.cupCheck.isSelected = true
                }
                if product.elementsEqual("sanitary") {
                    self.periodPadsCheck.isSelected = true
                }
                if product.elementsEqual("plastic") {
                    self.plasticCheck.isSelected = true
                }
                if product.elementsEqual("reusable") {
                    self.reusableCheck.isSelected = true
                }
                
            }
        }
        
    }
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        ProgressHUDShow(text: "")
        var list = Array<String>()
        if periodPadsCheck.isSelected {
            list.append("sanitary")
        }
        if tamponsCheck.isSelected {
            list.append("tampons")
        }
        if cupCheck.isSelected {
            list.append("menstrual")
        }
        if plasticCheck.isSelected {
            list.append("plastic")
        }
        if reusableCheck.isSelected {
            list.append("reusable")
        }
        
        OrganiserModel.data!.products = list
        try? Firestore.firestore().collection("Organisers").document(OrganiserModel.data!.uid ?? "123").setData(from: OrganiserModel.data!, merge: true) { error in
            self.ProgressHUDHide()
            if let error = error {
                self.showError(error.localizedDescription)
            }
            else {
                self.showSnack(messages: "Saved")
            }
        }
        
    }
    
    
}
