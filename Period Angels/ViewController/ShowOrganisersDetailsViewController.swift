//
//  ShowOrganisersDetailsViewController.swift
//  Period Angels
//
//  Created by Vijay Rathore on 03/01/23.
//

import UIKit
import MapKit

class ShowOrganisersDetailsViewController : UIViewController {

    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var businessView: UIView!
    @IBOutlet weak var businessImg: UIImageView!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var padsView: UIView!
    @IBOutlet weak var tamponsView: UIView!
    @IBOutlet weak var cupView: UIView!
    @IBOutlet weak var plasticFreeView: UIView!
    
    @IBOutlet weak var reuseView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var mondayTime: UILabel!
    @IBOutlet weak var tuesdayTime: UILabel!
    @IBOutlet weak var wednesdayTime: UILabel!
    @IBOutlet weak var thursdayTime: UILabel!
    @IBOutlet weak var fridayTime: UILabel!
    @IBOutlet weak var saturdayTime: UILabel!
    @IBOutlet weak var sundayTime: UILabel!
    @IBOutlet weak var timeView: UIView!
    
    var organiserModel : OrganiserModel?
    override func viewDidLoad() {
        
        guard let organisationModel = organiserModel else {
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
            return
        }
        
        timeView.layer.cornerRadius = 8
        mapView.layer.cornerRadius = 8
        
        backView.isUserInteractionEnabled = true
        backView.layer.cornerRadius = 8
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtnClicked)))
        backView.dropShadow()
        
        
        name.text = organisationModel.name ?? "Name"
        phone.text = organisationModel.phoneNumber ?? "Phone"
        address.text = organisationModel.fullAddress ?? "Address"
        
        let coordinate1 = CLLocation(latitude: organisationModel.latitude ?? 0.0, longitude: organisationModel.longitude ?? 0.0)
        let coordinate2D = CLLocationCoordinate2D(latitude: organisationModel.latitude ?? 0.0, longitude: organisationModel.longitude ?? 0.0)
        setCoordinatesOnMap(with: coordinate2D)
        let coordinate2 = CLLocation(latitude: Constants.latitude, longitude: Constants.longitude)
        
        let distanceKM =  (coordinate1.distance(from: coordinate2)) / 1000.0
        distance.text = "\(String(format: "%.2f", distanceKM)) KM"
        
        padsView.layer.cornerRadius = 8
        padsView.isHidden = true
        tamponsView.layer.cornerRadius = 8
        tamponsView.isHidden = true
        cupView.layer.cornerRadius = 8
        cupView.isHidden = true
        plasticFreeView.layer.cornerRadius = 8
        plasticFreeView.isHidden = true
        reuseView.layer.cornerRadius = 8
        reuseView.isHidden = true
        
        if let mondayAvailable = organisationModel.mondayAvailable, mondayAvailable {
            mondayTime.text = "\(organisationModel.mondayStartTime!) To \(organisationModel.mondayEndTime!)"
        }
        else {
            mondayTime.text = "Closed"
        }
        
        if let tuesdayAvailable = organisationModel.tuesdayAvailable,tuesdayAvailable {
            tuesdayTime.text = "\(organisationModel.tuesdayStartTime!) To \(organisationModel.tuesdayEndTime!)"
        }
        else {
            tuesdayTime.text = "Closed"
        }
        
        if let wednesdayAvailable = organisationModel.wednesdayAvailable, wednesdayAvailable {
            wednesdayTime.text = "\(organisationModel.wednesdayStartTime!) To \(organisationModel.wednesdayEndTime!)"
        }
        else {
            wednesdayTime.text = "Closed"
        }
        
        if let thursdayAvailable = organisationModel.thursdayAvailable, thursdayAvailable {
            thursdayTime.text = "\(organisationModel.thursdayStartTime!) To \(organisationModel.thursdayEndTime!)"
        }
        else {
            thursdayTime.text = "Closed"
        }
        
        if let fridayAvailable = organisationModel.fridayAvailable, fridayAvailable {
            fridayTime.text = "\(organisationModel.fridayStartTime!) To \(organisationModel.fridayEndTime!)"
        }
        else {
            fridayTime.text = "Closed"
        }
        
        if let saturdayAvailable = organisationModel.saturdayAvailable, saturdayAvailable {
            saturdayTime.text = "\(organisationModel.saturdayStartTime!) To \(organisationModel.saturdayEndTime!)"
        }
        else {
            saturdayTime.text = "Closed"
        }
        
        if let sundayAvailable = organisationModel.sundayAvailable, sundayAvailable {
            sundayTime.text = "\(organisationModel.sundayStartTime!) To \(organisationModel.sundayEndTime!)"
        }
        else {
            sundayTime.text = "Closed"
        }
       
        
        businessView.layer.cornerRadius = 8
        
        if organisationModel.type!.elementsEqual("public") {
            businessName.text  = "Public"
            businessImg.image = UIImage(named: "building")
        }
        else if organisationModel.type!.elementsEqual("business") {
            businessName.text  = "Business"
            businessImg.image = UIImage(named: "shop")
        }
        else if organisationModel.type!.elementsEqual("charity") {
            businessName.text  = "Charity"
            businessImg.image  = UIImage(named: "charity")
        }
        else if organisationModel.type!.elementsEqual("other") {
            businessName.text   = "Other"
            businessImg.image = UIImage(named: "other")
        }
        
        if let products = organisationModel.products{
            for product in products {
                if product.elementsEqual("sanitary") {
                    padsView.isHidden = false
                }
                if product.elementsEqual("tampons") {
                    tamponsView.isHidden = false
                }
                if product.elementsEqual("menstrual") {
                    cupView.isHidden = false
                }
                if product.elementsEqual("plastic") {
                    plasticFreeView.isHidden = false
                }
                if product.elementsEqual("reusable") {
                    reuseView.isHidden = false
                }
            }
        }
    }
    
    @objc func backBtnClicked(){
        self.dismiss(animated: true)
    }
    
    func setCoordinatesOnMap(with coordinates : CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
    
        let anonation = mapView.annotations
        mapView.removeAnnotations(anonation)
        
        mapView.addAnnotation(pin)
        mapView.setRegion(MKCoordinateRegion(
                            center: coordinates,
                            span: MKCoordinateSpan(
                                latitudeDelta: 0.02,
                                longitudeDelta: 0.02)),
                            animated: true)
        mapView.isScrollEnabled = false
       
       
    }
}
