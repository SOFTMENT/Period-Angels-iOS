//
//  SetupVolunteerViewController.swift
//  Period Angels
//
//  Created by Vijay Rathore on 25/12/22.
//

import UIKit
import MapKit
import Firebase
import GeoFire


class SetupVolunteerViewController : UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var volunteerNameTF: UITextField!
    @IBOutlet weak var volunteerAddressTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
  
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var buildingNoTF: UITextField!
    @IBOutlet weak var streetAddressTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    
    @IBOutlet weak var postalCodeTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    
    var places : [Place] = []
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    var isLocationSelected : Bool = false
   
    
    
    override func viewDidLoad() {
        
        volunteerNameTF.delegate = self
        volunteerNameTF.changePlaceholderColour()
        volunteerNameTF.addBorder()
        volunteerNameTF.setLeftPaddingPoints(10)
        volunteerNameTF.setRightPaddingPoints(10)
        
        volunteerAddressTF.delegate = self
        volunteerAddressTF.changePlaceholderColour()
        volunteerAddressTF.addBorder()
        volunteerAddressTF.setLeftPaddingPoints(10)
        volunteerAddressTF.setRightPaddingPoints(10)
        
        buildingNoTF.delegate = self
        buildingNoTF.changePlaceholderColour()
        buildingNoTF.addBorder()
        buildingNoTF.setLeftPaddingPoints(10)
        buildingNoTF.setRightPaddingPoints(10)
        
        streetAddressTF.delegate = self
        streetAddressTF.changePlaceholderColour()
        streetAddressTF.addBorder()
        streetAddressTF.setLeftPaddingPoints(10)
        streetAddressTF.setRightPaddingPoints(10)
        
        cityTF.delegate = self
        cityTF.changePlaceholderColour()
        cityTF.addBorder()
        cityTF.setLeftPaddingPoints(10)
        cityTF.setRightPaddingPoints(10)
        
        postalCodeTF.delegate = self
        postalCodeTF.changePlaceholderColour()
        postalCodeTF.addBorder()
        postalCodeTF.setLeftPaddingPoints(10)
        postalCodeTF.setRightPaddingPoints(10)
        
        stateTF.delegate = self
        stateTF.changePlaceholderColour()
        stateTF.addBorder()
        stateTF.setLeftPaddingPoints(10)
        stateTF.setRightPaddingPoints(10)
        
        
        countryTF.delegate = self
        countryTF.changePlaceholderColour()
        countryTF.addBorder()
        countryTF.setLeftPaddingPoints(10)
        countryTF.setRightPaddingPoints(10)
        
        phoneNumberTF.delegate = self
        phoneNumberTF.changePlaceholderColour()
        phoneNumberTF.addBorder()
        phoneNumberTF.setLeftPaddingPoints(10)
        phoneNumberTF.setRightPaddingPoints(10)
        
        createAccountBtn.layer.cornerRadius = 8
        
        
        backView.dropShadow()
        backView.isUserInteractionEnabled = true
        backView.layer.cornerRadius = 8
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtnClicked)))
        
        volunteerAddressTF.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.contentInsetAdjustmentBehavior = .never
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44
        
    }
    
    @IBAction func createAccountBtnClicked(_ sender: Any) {
        
        let sVolunteerName = volunteerNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let sVolunteerAddress = volunteerAddressTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let sBuildingNumber = buildingNoTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let sStreetAddress = streetAddressTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let sCity = cityTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let sPostalCode = postalCodeTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let sVolunteerPhone = phoneNumberTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let sState = stateTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let sCountry = countryTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if sVolunteerName == "" {
            self.showSnack(messages: "Enter Volunteer Name")
        }
        else if sVolunteerAddress == "" || !isLocationSelected {
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
        else if sVolunteerPhone == "" {
            self.showSnack(messages: "Enter Phone Number")
        }
        else {
            
            ProgressHUDShow(text: "Creating Profile")
            let volunteerModel = VolunteerModel()
            let fullAddress = "\(sBuildingNumber ?? "") \(sStreetAddress ?? "") \(sCity ?? "") \(sState ?? "") \(sPostalCode ?? "") \(sCountry ?? "")"
            volunteerModel.name = sVolunteerName
            volunteerModel.fullAddress = fullAddress
            volunteerModel.emailId = UserModel.data!.email
            volunteerModel.registeredAt = Date()
            volunteerModel.uid = UserModel.data!.uid
            volunteerModel.phoneNumber = sVolunteerPhone
            volunteerModel.latitude = latitude
            volunteerModel.longitude = longitude
            volunteerModel.geoHash = GFUtils.geoHash(forLocation: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            
            let wb = Firestore.firestore().batch()
            let createOrganiserRef = Firestore.firestore().collection("Volunteers").document(volunteerModel.uid ?? "123")
            try? wb.setData(from: volunteerModel, forDocument: createOrganiserRef)
            
            let updateUserRef = Firestore.firestore().collection("Users").document(volunteerModel.uid ?? "123")
            UserModel.data!.volunteer = true
            try? wb.setData(from: UserModel.data!, forDocument: updateUserRef)
            wb.commit { error in
                self.ProgressHUDHide()
                if let error = error {
                    self.showSnack(messages: error.localizedDescription)
                }
                else {
                    self.beRootScreen(mIdentifier: Constants.StroyBoard.volunteerHomeController)
                }
            }
        }
        
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
        DispatchQueue.main.async {
            self.tableView.isHidden = true
        }
       
    }
    
    @objc func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    @objc func backBtnClicked(){
        beRootScreen(mIdentifier: Constants.StroyBoard.userSelectionViewController)
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
           
            view.endEditing(true)
         
            let place = places[myGesture.index]
            volunteerAddressTF.text = place.name ?? ""
            
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

}
extension SetupVolunteerViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}


extension SetupVolunteerViewController : UITableViewDelegate, UITableViewDataSource {
    
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
