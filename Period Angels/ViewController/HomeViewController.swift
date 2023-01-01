//
//  HomeViewController.swift
//  Period Angels
//
//  Created by Vijay Rathore on 02/01/23.
//

import UIKit

class HomeViewController : UIViewController {
    
    @IBOutlet weak var filterBtn: UIImageView!
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var notificationView: UIView!
    
    @IBOutlet weak var no_organisations_available: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        notificationView.dropShadow()
        notificationView.layer.cornerRadius = 8
        notificationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(notificationBtnClicked)))
        
        searchTF.setLeftIcons(icon: UIImage(named: "search-4")!)
        
        filterBtn.isUserInteractionEnabled = true
        filterBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(filterBtnClicked)))
    }
    
    @objc func filterBtnClicked(){
        
    }
    
    @objc func notificationBtnClicked(){
        performSegue(withIdentifier: "notificationCenterSeg", sender: nil)
    }
    
}
