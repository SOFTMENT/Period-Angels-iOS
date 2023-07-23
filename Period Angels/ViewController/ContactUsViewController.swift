//
//  ContactUsViewController.swift
//  Period Angels
//
//  Created by Vijay Rathore on 02/01/23.
//

import UIKit

class ContactUsViewController : UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var mMail: UILabel!
    @IBOutlet weak var mPhone: UILabel!
    @IBOutlet weak var fb: UIImageView!
    @IBOutlet weak var google: UIImageView!
    @IBOutlet weak var twitter: UIImageView!
    
    
    override func viewDidLoad() {
        backView.layer.cornerRadius = 8
        backView.dropShadow()
        backView.isUserInteractionEnabled = true
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backViewClicked)))
        
        mMail.isUserInteractionEnabled = true
        mMail.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(emailClicked)))
        
        mPhone.isUserInteractionEnabled = true
        mPhone.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(phoneClicked)))
        
        google.isUserInteractionEnabled = true
        google.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(googleClicked)))
        
        fb.isUserInteractionEnabled = true
        fb.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(facebookClicked)))
        
        twitter.isUserInteractionEnabled = true
        twitter.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(twitterClicked)))
    }
    
    @objc func googleClicked(){
        guard let url = URL(string: "https://www.instagram.com/periodangelsapp") else { return}
        UIApplication.shared.open(url)
    }
    
    @objc func facebookClicked(){
        guard let url = URL(string: "https://www.facebook.com/periodangelsapp") else { return}
        UIApplication.shared.open(url)
    }
    
    @objc func twitterClicked(){
        guard let url = URL(string: "https://twitter.com/periodangelsapp") else { return}
        UIApplication.shared.open(url)
    }
    
    @objc func emailClicked(){
        if let url = URL(string: "mailto:appteam@periodpoverty.uk") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @objc func phoneClicked(){
        let phoneNumber = "+44 (0)1332 318311"
        if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {

               let application:UIApplication = UIApplication.shared
               if (application.canOpenURL(phoneCallURL)) {
                   if #available(iOS 10.0, *) {
                       application.open(phoneCallURL, options: [:], completionHandler: nil)
                   } else {
                       // Fallback on earlier versions
                        application.openURL(phoneCallURL as URL)

                   }
               }
           }
    }
    
    @objc func backViewClicked(){
        self.dismiss(animated: true)
    }
    
}
