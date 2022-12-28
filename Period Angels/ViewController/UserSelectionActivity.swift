//
//  UserSelectionActivity.swift
//  Period Angels
//
//  Created by Vijay Rathore on 25/12/22.
//

import UIKit

class UserSelectionActivity : UIViewController {
    
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var volunteerView: UIView!
    @IBOutlet weak var organisationView: UIView!
    
    @IBOutlet weak var arrow1: UIView!
    @IBOutlet weak var arrow2: UIView!
    @IBOutlet weak var arrow3: UIView!
    
    override func viewDidLoad() {
        userView.layer.cornerRadius = 8
        volunteerView.layer.cornerRadius = 8
        organisationView.layer.cornerRadius = 8
        
        userView.isUserInteractionEnabled = true
        userView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userViewClicked)))
        
        organisationView.isUserInteractionEnabled = true
        organisationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(organisationViewClicked)))
        
        volunteerView.isUserInteractionEnabled = true
        volunteerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(volunteerViewClicked)))
        
        arrow1.layer.cornerRadius = 8
        arrow2.layer.cornerRadius = 8
        arrow3.layer.cornerRadius = 8
        
        arrow1.dropShadow()
        arrow2.dropShadow()
        arrow3.dropShadow()
    }
    
    @objc func userViewClicked(){
        UserDefaults().set("user", forKey: "userType")
        self.beRootScreen(mIdentifier: Constants.StroyBoard.tabBarViewController)
        
    }
    
    @objc func organisationViewClicked(){
        UserDefaults().set("organiser", forKey: "userType")
        
        if let isOrganiser = UserModel.data!.organizer, isOrganiser {
            self.getOrganiserData(uid: UserModel.data!.uid ?? "123", showProgress: true)
        }
        else{
            self.beRootScreen(mIdentifier: Constants.StroyBoard.setupOrganiserController)
        }
    }
    
    @objc func volunteerViewClicked(){
        UserDefaults().set("volunteer", forKey: "userType")
        
        if let isVolunteer = UserModel.data!.volunteer, isVolunteer {
            self.getVolunteerData(uid: UserModel.data!.uid ?? "123", showProgress: true)
        }
        else{
            self.beRootScreen(mIdentifier: Constants.StroyBoard.setupVolunteerController)
        }
    }
    
}
