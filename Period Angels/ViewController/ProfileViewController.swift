//
//  ProfileViewController.swift
//  Period Angels
//
//  Created by Vijay Rathore on 02/01/23.
//

import UIKit
import StoreKit
import Firebase

class ProfileViewController : UIViewController {
    
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var notificationCentre: UIView!
    @IBOutlet weak var switchToOrganiser: UIView!
    @IBOutlet weak var switchToVolunteer: UIView!
    @IBOutlet weak var contactUs: UIView!
    @IBOutlet weak var rateApp: UIView!
    @IBOutlet weak var shareApp: UIView!
    @IBOutlet weak var versionCode: UILabel!
    @IBOutlet weak var privacyPolicy: UIView!
    @IBOutlet weak var logout : UILabel!
    @IBOutlet weak var deleteAccountBtn: UIView!
    
    override func viewDidLoad() {
      
        notificationCentre.isUserInteractionEnabled = true
        notificationCentre.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(notficationCentreClicked)))
        
        switchToOrganiser.isUserInteractionEnabled = true
        switchToOrganiser.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(switchToOrganiserClicked)))
        
        switchToVolunteer.isUserInteractionEnabled = true
        switchToVolunteer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(switchToVolunterClicked)))
        
        contactUs.isUserInteractionEnabled = true
        contactUs.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(contactUsClicked)))
        
        rateApp.isUserInteractionEnabled = true
        rateApp.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rateAppClicked)))
        
        shareApp.isUserInteractionEnabled = true
        shareApp.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shareAppClicked)))
            
        privacyPolicy.isUserInteractionEnabled = true
        privacyPolicy.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(privacyPolicyClicked)))
        
        logout.isUserInteractionEnabled = true
        logout.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logoutClicked)))
        
        deleteAccountBtn.isUserInteractionEnabled = true
        deleteAccountBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deleteAccountClicked)))
        deleteAccountBtn.layer.cornerRadius =  8
        deleteAccountBtn.layer.borderColor = UIColor.red.cgColor
        deleteAccountBtn.layer.borderWidth = 1
        
        if Auth.auth().currentUser == nil {
            switchToOrganiser.isHidden = true
            switchToVolunteer.isHidden = true
            
            deleteAccountBtn.isHidden = true
            logout.isHidden = true
        }
        else {
            username.text = UserModel.data!.fullName ?? ""
            emailAddress.text = UserModel.data!.email ?? ""
        }
        
    }
    
    @objc func notficationCentreClicked(){
        performSegue(withIdentifier: "settings_notificationSeg", sender: nil)
    }
    
    @objc func switchToOrganiserClicked(){
        UserDefaults().set("organisation", forKey: "userType")
        if let isOrganiser = UserModel.data!.organizer, isOrganiser {
            self.getOrganiserData(uid: Auth.auth().currentUser!.uid, showProgress: true)
        }
        else {
            self.beRootScreen(mIdentifier: Constants.StroyBoard.setupOrganiserController)
        }
    }
    
    @objc func switchToVolunterClicked(){
        UserDefaults().set("volunteer", forKey: "userType")
        if let isVolunteer = UserModel.data!.volunteer, isVolunteer {
            self.getVolunteerData(uid: Auth.auth().currentUser!.uid, showProgress: true)
        }
        else {
            self.beRootScreen(mIdentifier: Constants.StroyBoard.setupVolunteerController)
        }
    }
    
    @objc func contactUsClicked(){
        performSegue(withIdentifier: "contactUsSeg", sender: nil)
    }
    
    @objc func rateAppClicked(){
        
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
    
    @objc func shareAppClicked(){
        let someText:String = "Check Out Period Angels App"
        let objectsToShare:URL = URL(string: "https://apps.apple.com/us/app/period-angels/id1662276811")!
        let sharedObjects:[AnyObject] = [objectsToShare as AnyObject,someText as AnyObject]
        let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func privacyPolicyClicked(){
        guard let url = URL(string: "https://softment.in/periodangels/privacypolicy.html") else { return}
        UIApplication.shared.open(url)
    
    }
    
    @objc func logoutClicked(){
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Logout", style: .default,handler: { action in
            
            UserDefaults().set("", forKey: "userType")
            self.logout()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
    
    @objc func deleteAccountClicked(){
        let alert = UIAlertController(title: "DELETE ACCOUNT", message: "Are you sure you want to delete your account?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            
            if let user = Auth.auth().currentUser {
                
                self.ProgressHUDShow(text: "Account Deleting...")
                let userId = user.uid
                
                        Firestore.firestore().collection("Users").document(userId).delete { error in
                           
                            if error == nil {
                                user.delete { error in
                                    self.ProgressHUDHide()
                                    if error == nil {
                                        self.logout()
                                        
                                    }
                                    else {
                                        self.beRootScreen(mIdentifier: Constants.StroyBoard.signInViewController)
                                    }
    
                                
                                }
                                
                            }
                            else {
                       
                                self.showError(error!.localizedDescription)
                            }
                        }
                    
                }
            
            
        }))
        present(alert, animated: true)
    }
}
