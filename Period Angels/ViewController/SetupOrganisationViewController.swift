//
//  SetupOrganisationViewController.swift
//  Period Angels
//
//  Created by Vijay Rathore on 25/12/22.
//

import UIKit
import MapKit
import GeoFire
import Firebase

class SetupOrganisationViewController : UIViewController {
    
   
  
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var organisationNameTF: UITextField!
    @IBOutlet weak var organisationAddressTF: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var buildingNoTF: UITextField!
    @IBOutlet weak var streetAddressTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var postalCodeTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var businessBtn: UIButton!
    @IBOutlet weak var charityBtn: UIButton!
    @IBOutlet weak var publicBuildingBtn: UIButton!
    @IBOutlet weak var otherBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    
    var places : [Place] = []
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    var isLocationSelected : Bool = false
    var organisationType = ""
    
    override func viewDidLoad() {
          
        
        organisationNameTF.delegate = self
        organisationNameTF.changePlaceholderColour()
        organisationAddressTF.delegate = self
        organisationAddressTF.changePlaceholderColour()
        mapView.layer.cornerRadius = 8
        buildingNoTF.delegate = self
        buildingNoTF.changePlaceholderColour()
        streetAddressTF.delegate = self
        streetAddressTF.changePlaceholderColour()
        cityTF.delegate = self
        cityTF.changePlaceholderColour()
        postalCodeTF.delegate = self
        postalCodeTF.changePlaceholderColour()
        phoneNumberTF.delegate = self
        phoneNumberTF.changePlaceholderColour()
        createAccountBtn.layer.cornerRadius = 8
    
        stateTF.delegate = self
        stateTF.changePlaceholderColour()
        countryTF.delegate = self
        countryTF.changePlaceholderColour()
        
        backView.dropShadow()
        backView.isUserInteractionEnabled = true
        backView.layer.cornerRadius = 8
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtnClicked)))
        
        organisationAddressTF.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        organisationAddressTF.changePlaceholderColour()
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.contentInsetAdjustmentBehavior = .never
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44
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
    
    
    public func updateTableViewHeight(){
        
        self.tableViewHeight.constant = self.tableView.contentSize.height
        self.tableView.layoutIfNeeded()
    }
    
    @objc func textFieldDidChange(textField : UITextField){
        guard let query = textField.text, !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            self.places.removeAll()
        
            self.tableView.reloadData()
            return
        }
        
        
        GooglePlacesManager.shared.findPlaces(query: query ) { result in
            switch result {
            case .success(let places) :
                self.places = places
            
                print(self.places)
                self.tableView.reloadData()
                break
            case .failure(let error) :
                print(error)
            }
        }
    }
    
    @objc func locationCellClicked(myGesture : MyGesture){
        tableView.isHidden = true
        view.endEditing(true)
    

        let place = places[myGesture.index]
        organisationAddressTF.text = place.name ?? ""
        
        self.isLocationSelected = true
     
    
        GooglePlacesManager.shared.resolveLocation(for: place) { result in
            switch result {
            case .success(let coordinates) :
                self.latitude = coordinates.latitude
                self.longitude = coordinates.longitude
                
                
                let coordinates = CLLocationCoordinate2D(latitude: self.latitude , longitude: self.longitude )
                
                self.setCoordinatesOnMap(with: coordinates)

                break
            case .failure(let error) :
                print(error)
                
            }
        }
    }

    @IBAction func businessBtnclicked(_ sender: Any) {
        
        businessBtn.isSelected = true
        charityBtn.isSelected = false
        publicBuildingBtn.isSelected = false
        otherBtn.isSelected = false
        self.organisationType = "business"
    }
    
    @IBAction func charityBtnClicked(_ sender: Any) {
        businessBtn.isSelected = false
        charityBtn.isSelected = true
        publicBuildingBtn.isSelected = false
        otherBtn.isSelected = false
        self.organisationType = "charity"
    }
    
    @IBAction func publicBuildingBtnClicked(_ sender: Any) {
        businessBtn.isSelected = false
        charityBtn.isSelected = false
        publicBuildingBtn.isSelected = true
        otherBtn.isSelected = false
        self.organisationType = "public"
    }
    
    @IBAction func otherBtnClicked(_ sender: Any) {
        businessBtn.isSelected = false
        charityBtn.isSelected = false
        publicBuildingBtn.isSelected = false
        otherBtn.isSelected = true
        self.organisationType = "other"
    }
    
    @IBAction func createAccountBtnClicked(_ sender: Any) {
        let sOrganisationName = organisationNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let sOrganisationAddress = organisationAddressTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let sBuildingNumber = organisationNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let sStreetAddress = streetAddressTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let sCity = cityTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let sPostalCode = postalCodeTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let sOrganisationPhoneNumber = phoneNumberTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let sState = stateTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let sCountry = countryTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if sOrganisationName == "" {
            self.showSnack(messages: "Enter Organisation Name")
        }
        else if sOrganisationAddress == "" || !isLocationSelected {
            self.showSnack(messages: "Enter Address")
        }
        else if sBuildingNumber == "" {
            self.showSnack(messages: "Enter Building Number")
        }
        else if sStreetAddress == "" {
            self.showSnack(messages: "Enter Street Address")
        }
        else if sCity == "" {
            self.showSnack(messages: "Enter City Name")
        }
        else if sPostalCode == "" {
            self.showSnack(messages: "Enter Postal Code")
        }
        else if sState == "" {
            self.showSnack(messages: "Enter State Name")
        }
        else if sCountry == "" {
            self.showSnack(messages: "Enter Country Name")
        }
        else if sOrganisationPhoneNumber == "" {
            self.showSnack(messages: "Enter Phone Number")
        }
        else if organisationType == "" {
            self.showSnack(messages: "Select Organisation Type")
        }
        else {
            ProgressHUDShow(text: "Creating Profile")
            let fullAddress = "\(sBuildingNumber ?? "") \(sStreetAddress ?? "") \(sCity ?? "") \(sState ?? "") \(sPostalCode ?? "") \(sCountry ?? "")"
            
            let organisationModel  = OrganiserModel()
            organisationModel.name = sOrganisationName
            organisationModel.fullAddress = fullAddress
            organisationModel.emailId = UserModel.data!.email
            organisationModel.registeredAt = Date()
            organisationModel.uid = UserModel.data!.uid
            organisationModel.type = self.organisationType
            organisationModel.phoneNumber = sOrganisationPhoneNumber
            organisationModel.latitude = latitude
            organisationModel.longitude = longitude
            organisationModel.geoHash = GFUtils.geoHash(forLocation: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            
            let wb = Firestore.firestore().batch()
            let createOrganiserRef = Firestore.firestore().collection("Organisers").document(organisationModel.uid ?? "123")
            try? wb.setData(from: organisationModel, forDocument: createOrganiserRef)
            
            let updateUserRef = Firestore.firestore().collection("Users").document(organisationModel.uid ?? "123")
            UserModel.data!.organizer = true
            try? wb.setData(from: UserModel.data!, forDocument: updateUserRef)
            wb.commit { error in
                self.ProgressHUDHide()
                if let error = error {
                    self.showSnack(messages: error.localizedDescription)
                }
                else {
                    self.beRootScreen(mIdentifier: Constants.StroyBoard.organiserHomeController)
                }
            }
        }
    }
    
    @objc func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    @objc func backBtnClicked(){
        beRootScreen(mIdentifier: Constants.StroyBoard.userSelectionViewController)
    }

}

extension SetupOrganisationViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}


extension SetupOrganisationViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if places.count > 0 {
            addressView.isHidden = false
            tableView.isHidden = false
        }
        else {
            addressView.isHidden = true
            tableView.isHidden = true
        }
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "placescell", for: indexPath) as? Google_Places_Cell {
            
            
            cell.name.text = places[indexPath.row].name ?? "Something Went Wrong"
            cell.mView.isUserInteractionEnabled = true
            
            let myGesture = MyGesture(target: self, action: #selector(locationCellClicked(myGesture:)))
            myGesture.index = indexPath.row
            cell.mView.addGestureRecognizer(myGesture)
            
            let totalRow = tableView.numberOfRows(inSection: indexPath.section)
            if(indexPath.row == totalRow - 1)
            {
                DispatchQueue.main.async {
                    self.updateTableViewHeight()
                }
            }
            return cell
        }
        
        return Google_Places_Cell()
    }
    
    
    
}
