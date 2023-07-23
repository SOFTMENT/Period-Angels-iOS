//
//  VolunteerViewController.swift
//  Period Angels
//
//  Created by Vijay Rathore on 25/12/22.
//

import UIKit
import Firebase
class VolunteerHomeController : UIViewController {
    
    @IBOutlet weak var volunteerName: UILabel!
    @IBOutlet weak var volunteerPhoneNumber: UILabel!
    @IBOutlet weak var volunteerAddress: UILabel!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var fiveStepsGuideView: UIView!
    @IBOutlet weak var stepView1: UIView!
    @IBOutlet weak var stepView2: UIView!
    @IBOutlet weak var stepView3: UIView!
    @IBOutlet weak var stepView4: UIView!
    @IBOutlet weak var stepView5: UIView!
    @IBOutlet weak var gotoOrganisationBtn: UILabel!
    @IBOutlet weak var periodAngelsPackBtn: UILabel!
    
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var gotoOrganisation: UILabel!
    @IBOutlet weak var periodAngelsVolunteerPack: UILabel!
    
    
    override func viewDidLoad() {
      
        settingsView.isUserInteractionEnabled = true
        settingsView.layer.cornerRadius = 8
        settingsView.dropShadow()
        
        fiveStepsGuideView.layer.cornerRadius = 8
        fiveStepsGuideView.layer.borderColor = UIColor.black.cgColor
        fiveStepsGuideView.layer.borderWidth = 0.8
        
        stepView1.layer.cornerRadius = 8
        stepView2.layer.cornerRadius = 8
        stepView3.layer.cornerRadius = 8
        stepView4.layer.cornerRadius = 8
        stepView5.layer.cornerRadius = 8
        
        volunteerName.text = VolunteerModel.data!.name ?? "Name"
        volunteerPhoneNumber.text = VolunteerModel.data!.phoneNumber ?? "Phone"
        volunteerAddress.text = VolunteerModel.data!.fullAddress ?? "Address"
        settingsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(settingsViewClicked)))
        
        periodAngelsVolunteerPack.isUserInteractionEnabled = true
        periodAngelsVolunteerPack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(volunteerPackClicked)))
        
        gotoOrganisation.isUserInteractionEnabled = true
        gotoOrganisation.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gotoOrganisationClicked)))
        
        let tampons : Int = (VolunteerModel.data!.tampons ?? 0)
        let pads : Int = (VolunteerModel.data!.periodPads ?? 0)
        let cups : Int = (VolunteerModel.data!.menstrualCup ?? 0)
        let reusable : Int = (VolunteerModel.data!.reusableProducts ?? 0)

        let totalProducts = tampons + pads + cups + reusable
        
        if totalProducts > 0 {
            productCount.text = "You've collected \(totalProducts) products so far... Angel Power!"
        }
        
        
    }
    
    @objc func volunteerPackClicked(){
        UIApplication.shared.open(URL(string: "https://drive.google.com/drive/folders/1Fr7JmBK79kJWmF6GVKYiqS9PeRCel09i?usp=sharing")!)
    }
   
    @objc func gotoOrganisationClicked(){
        UserDefaults().set("user", forKey: "userType")
        Constants.selectedPage = 2
        self.getUserData(uid: Auth.auth().currentUser!.uid, showProgress: true)
    }
    
    @objc func settingsViewClicked(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Manage Products", style: .default,handler: { action in
            self.performSegue(withIdentifier: "manageProductSeg", sender: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Go to User", style: .default,handler: { action in
            UserDefaults().set("user", forKey: "userType")
    
            self.getUserData(uid: Auth.auth().currentUser!.uid, showProgress: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Go to Organisation", style: .default,handler: { action in
            UserDefaults().set("organisation", forKey: "userType")
            if let isOrganiser = UserModel.data!.organizer, isOrganiser {
                self.getOrganiserData(uid: Auth.auth().currentUser!.uid, showProgress: true)
            }
            else {
                self.beRootScreen(mIdentifier: Constants.StroyBoard.setupOrganiserController)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Privacy Policy", style: .default,handler: { action in
            guard let url = URL(string: "https://softment.in/periodangels/privacypolicy.html") else { return}
            UIApplication.shared.open(url)
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
    
}
