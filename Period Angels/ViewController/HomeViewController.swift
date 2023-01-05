//
//  HomeViewController.swift
//  Period Angels
//
//  Created by Vijay Rathore on 02/01/23.
//

import UIKit
import CoreLocation

class HomeViewController : UIViewController {
    
    @IBOutlet weak var filterBtn: UIImageView!
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var notificationView: UIView!
    
    @IBOutlet weak var no_organisations_available: UIStackView!
    @IBOutlet weak var tableView: UITableView!
  
    var selectedValue = "All"
    var tempOrganiserModels : [OrganiserModel] = []
    override func viewDidLoad() {
        
        notificationView.dropShadow()
        notificationView.layer.cornerRadius = 8
        notificationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(notificationBtnClicked)))
        
        searchTF.setLeftIcons(icon: UIImage(named: "search-4")!)
        searchTF.delegate = self
        searchTF.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        filterBtn.isUserInteractionEnabled = true
        filterBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(filterBtnClicked)))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    
    }
    
    @objc func cellClicked(value : MyGesture){
        let organiser = tempOrganiserModels[value.index]
        performSegue(withIdentifier: "showDetailsSeg", sender: organiser)
         
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailsSeg" {
            if let vc = segue.destination as? ShowOrganisersDetailsViewController {
                if let organiser = sender as? OrganiserModel {
                    vc.organiserModel = organiser
                }
            }
        }
    }
    
    @objc func textFieldDidChange(textField : UITextField){
        tempOrganiserModels.removeAll()
        
            if let query = textField.text, !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            
            
                for organiser in OrganiserModel.organisationModel {
                    if organiser.name!.lowercased().contains(query.lowercased()) {
                        self.tempOrganiserModels.append(organiser)
                    }
                }
            
            tableView.reloadData()
            return
        }
        
        
        self.tempOrganiserModels = OrganiserModel.organisationModel
        tableView.reloadData()
        
    }
    @objc func filterBtnClicked(){


           let action = UIAlertController.actionSheetWithItems(items: [("All","All"),("Period Pads","Period Pads"),("Tampons","Tampons"),("Menstrual Cup","Menstrual Cup"),("Plastic Free","Plastic Free"),("Reusable Products","Reusable Products")], currentSelection: selectedValue, action: { (value)  in
               self.selectedValue = value
               
               self.tempOrganiserModels.removeAll()
               if value.elementsEqual("All") {
                   self.tempOrganiserModels = OrganiserModel.organisationModel
               }
               else {
                   for organiser in OrganiserModel.organisationModel {
                       if value.elementsEqual("Period Pads") {
                           if let hasValue =  organiser.products?.contains("sanitary"), hasValue{
                               self.tempOrganiserModels.append(organiser)
                           }
                       }
                       else if value.elementsEqual("Tampons") {
                           if let hasValue =  organiser.products?.contains("tampons"), hasValue {
                               self.tempOrganiserModels.append(organiser)
                           }
                       }
                       else if value.elementsEqual("Menstrual Cup") {
                           if let hasValue =  organiser.products?.contains("menstrual"), hasValue {
                               self.tempOrganiserModels.append(organiser)
                           }
                       }
                       else if value.elementsEqual("Plastic Free") {
                           if let hasValue =  organiser.products?.contains("plastic"), hasValue {
                               self.tempOrganiserModels.append(organiser)
                           }
                       }
                       else if value.elementsEqual("Reusable Products") {
                           if let hasValue =  organiser.products?.contains("reusable"), hasValue {
                               self.tempOrganiserModels.append(organiser)
                           }
                       }
                       
                   }
               }
              
                   
               self.tableView.reloadData()
               
           })
           action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
           //Present the controller
           self.present(action, animated: true, completion: nil)
    }
    
    @objc func notificationBtnClicked(){
        performSegue(withIdentifier: "notificationCenterSeg", sender: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tempOrganiserModels.removeAll()
        tempOrganiserModels = OrganiserModel.organisationModel
        self.tableView.reloadData()
    }
    
    
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        no_organisations_available.isHidden = tempOrganiserModels.count > 0 ? true : false
        
        return tempOrganiserModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "organisationCell", for: indexPath) as? Organisation_View_Cell {
            
            cell.businessView.layer.cornerRadius = 8
            
            cell.padsView.layer.cornerRadius = 8
            cell.padsView.isHidden = true
            cell.tampomsView.layer.cornerRadius = 8
            cell.tampomsView.isHidden = true
            cell.cupView.layer.cornerRadius = 8
            cell.cupView.isHidden = true
            cell.plasticFreeView.layer.cornerRadius = 8
            cell.plasticFreeView.isHidden = true
            cell.reusableView.layer.cornerRadius = 8
            cell.reusableView.isHidden = true
            
            cell.mView.layer.cornerRadius = 8
            
            let organisationModel = tempOrganiserModels[indexPath.row]
            
            cell.organisationName.text = organisationModel.name ?? ""
            
            if organisationModel.type!.elementsEqual("public") {
                cell.businessName.text  = "Public"
                cell.businessImg.image = UIImage(named: "building")
            }
            else if organisationModel.type!.elementsEqual("business") {
                cell.businessName.text  = "Business"
                cell.businessImg.image = UIImage(named: "shop")
            }
            else if organisationModel.type!.elementsEqual("charity") {
                cell.businessName.text  = "Charity"
                cell.businessImg.image  = UIImage(named: "charity")
            }
            else if organisationModel.type!.elementsEqual("other") {
                cell.businessName.text   = "Other"
                cell.businessImg.image = UIImage(named: "other")
            }
            
            if let products = organisationModel.products{
                for product in products {
                    if product.elementsEqual("sanitary") {
                        cell.padsView.isHidden = false
                    }
                    if product.elementsEqual("tampons") {
                        cell.tampomsView.isHidden = false
                    }
                    if product.elementsEqual("menstrual") {
                        cell.cupView.isHidden = false
                    }
                    if product.elementsEqual("plastic") {
                        cell.plasticFreeView.isHidden = false
                    }
                    if product.elementsEqual("reusable") {
                        cell.reusableView.isHidden = false
                    }
                }
            }
            
            let coordinate1 = CLLocation(latitude: organisationModel.latitude ?? 0.0, longitude: organisationModel.longitude ?? 0.0)
            let coordinate2 = CLLocation(latitude: Constants.latitude, longitude: Constants.longitude)
            
            let distanceKM =  (coordinate1.distance(from: coordinate2)) / 1000.0
            cell.distance.text = "\(String(format: "%.2f", distanceKM)) KM"
  
            cell.mView.isUserInteractionEnabled = true
            let myGest = MyGesture(target: self, action: #selector(cellClicked(value: )))
            myGest.index = indexPath.row
            cell.mView.addGestureRecognizer(myGest)
            
            return cell
        }
        
        return Organisation_View_Cell()
    }
    
    
    
    
    
    
}


extension HomeViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    

}
