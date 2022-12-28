//
//  ManageAvailablityViewController.swift
//  Period Angels
//
//  Created by Vijay Rathore on 28/12/22.
//

import UIKit
import Firebase


class ManageAvailablityViewController : UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var mondayStartTime: UITextField!
    @IBOutlet weak var mondayEndTime: UITextField!
    
    @IBOutlet weak var tuesdayStartTime: UITextField!
    @IBOutlet weak var tuesdayEndTime: UITextField!
    
    @IBOutlet weak var wednesdayStartTime: UITextField!
    @IBOutlet weak var wednesdayEndTime: UITextField!
    
    @IBOutlet weak var thursdayStartTime: UITextField!
    @IBOutlet weak var thursdayEndTime: UITextField!
    
    @IBOutlet weak var fridayStartTime: UITextField!
    @IBOutlet weak var fridayEndTime: UITextField!
    
    @IBOutlet weak var saturdayStartTime: UITextField!
    @IBOutlet weak var saturdayEndTime: UITextField!
    
    @IBOutlet weak var sundayStartTime: UITextField!
    @IBOutlet weak var sundayEndTime: UITextField!
    
    @IBOutlet weak var mondayCheck: UIButton!
    @IBOutlet weak var tuesdayCheck: UIButton!
    @IBOutlet weak var wednesdayCheck: UIButton!
    @IBOutlet weak var thursdayCheck: UIButton!
    @IBOutlet weak var fridayCheck: UIButton!
    @IBOutlet weak var saturdaycheck: UIButton!
    @IBOutlet weak var sundayCheck: UIButton!
    
    let mondayStartTimePicker = UIDatePicker()
    let mondayEndTimePicker = UIDatePicker()
    
    let tuesdayStartTimePicker = UIDatePicker()
    let tuesdayEndTimePicker = UIDatePicker()
    
    let wednesdayStartTimePicker = UIDatePicker()
    let wednesdayEndTimePicker = UIDatePicker()
    
    let thursdayStartTimePicker = UIDatePicker()
    let thursdayEndTimePicker = UIDatePicker()
    
    let fridayStartTimePicker = UIDatePicker()
    let fridayEndTimePicker = UIDatePicker()
    
    let saturdayStartTimePicker = UIDatePicker()
    let saturdayEndTimePicker = UIDatePicker()
    
    let sundayStartTimePicker = UIDatePicker()
    let sundayEndTimePicker = UIDatePicker()
    
  
    override func viewDidLoad() {
        
        backView.layer.cornerRadius = 8
        backView.dropShadow()
        backView.isUserInteractionEnabled = true
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtnClicked)))
        
        mondayStartTime.delegate = self
        mondayEndTime.delegate = self
        
        tuesdayStartTime.delegate = self
        tuesdayEndTime.delegate = self
        
        wednesdayStartTime.delegate = self
        wednesdayEndTime.delegate = self
        
        thursdayStartTime.delegate = self
        thursdayEndTime.delegate = self
        
        fridayStartTime.delegate = self
        fridayEndTime.delegate = self
        
        saturdayStartTime.delegate = self
        saturdayEndTime.delegate = self
        
        sundayStartTime.delegate = self
        sundayEndTime.delegate = self
        
        mondayStartTime.text = OrganiserModel.data!.mondayStartTime ?? "07:00 AM"
        mondayEndTime.text = OrganiserModel.data!.mondayEndTime ?? "011:00 PM"
        
        tuesdayStartTime.text = OrganiserModel.data!.tuesdayStartTime ?? "07:00 AM"
        tuesdayEndTime.text = OrganiserModel.data!.tuesdayEndTime ?? "011:00 PM"
        
        wednesdayStartTime.text = OrganiserModel.data!.wednesdayStartTime ?? "07:00 AM"
        wednesdayEndTime.text = OrganiserModel.data!.wednesdayEndTime ?? "011:00 PM"
        
        thursdayStartTime.text = OrganiserModel.data!.thursdayStartTime ?? "07:00 AM"
        thursdayEndTime.text = OrganiserModel.data!.thursdayEndTime ?? "011:00 PM"
        
        fridayStartTime.text = OrganiserModel.data!.fridayStartTime ?? "07:00 AM"
        fridayEndTime.text = OrganiserModel.data!.fridayEndTime ?? "011:00 PM"
        
        saturdayStartTime.text = OrganiserModel.data!.saturdayStartTime ?? "07:00 AM"
        saturdayEndTime.text = OrganiserModel.data!.saturdayEndTime ?? "011:00 PM"
        
        sundayStartTime.text = OrganiserModel.data!.sundayStartTime ?? "07:00 AM"
        sundayEndTime.text = OrganiserModel.data!.sundayEndTime ?? "011:00 PM"
        
        
        createMondayStartTimePicker()
        createMondayEndTimePicker()
        
        createTuesdayStartTimePicker()
        createTuesdayEndTimePicker()
        
        createWednesdayStartTimePicker()
        createWednesdayEndTimePicker()
        
        createThursdayStartTimePicker()
        createThursdayEndTimePicker()
        
        createFridayStartTimePicker()
        createFridayEndTimePicker()
        
        createSaturdayStartTimePicker()
        createSaturdayEndTimePicker()
        
        createSundayStartTimePicker()
        createSundayEndTimePicker()
        
        mondayCheck.isSelected = OrganiserModel.data!.mondayAvailable ?? false
        tuesdayCheck.isSelected = OrganiserModel.data!.tuesdayAvailable ?? false
        wednesdayCheck.isSelected = OrganiserModel.data!.wednesdayAvailable ?? false
        thursdayCheck.isSelected = OrganiserModel.data!.thursdayAvailable ?? false
        fridayCheck.isSelected = OrganiserModel.data!.fridayAvailable ?? false
        saturdaycheck.isSelected = OrganiserModel.data!.saturdayAvailable ?? false
        sundayCheck.isSelected = OrganiserModel.data!.sundayAvailable ?? false
        
        
    }
    
    
    func createMondayStartTimePicker() {
     
        mondayStartTime.isUserInteractionEnabled = true
        mondayStartTimePicker.preferredDatePickerStyle = .wheels
    
   
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(mondayStartTimeDoneBtnTapped))
        toolbar.setItems([done], animated: true)
      
        mondayStartTime.inputAccessoryView = toolbar

        mondayStartTimePicker.datePickerMode = .time
        mondayStartTime.inputView = mondayStartTimePicker
    }
    @objc func mondayStartTimeDoneBtnTapped() {
        view.endEditing(true)
        let date = mondayStartTimePicker.date
        mondayStartTime.text = convertTimeFormater(date)
        OrganiserModel.data!.mondayStartTime = mondayStartTime.text
        updateOnFirebase(organiserModel: OrganiserModel.data!)
    }
    
    func createMondayEndTimePicker() {
        mondayEndTime.isUserInteractionEnabled = true
            mondayEndTimePicker.preferredDatePickerStyle = .wheels

   
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(mondayEndTimeDoneBtnTapped))
        toolbar.setItems([done], animated: true)
      
        mondayEndTime.inputAccessoryView = toolbar

        mondayEndTimePicker.datePickerMode = .time
        mondayEndTime.inputView = mondayEndTimePicker
    }
    @objc func mondayEndTimeDoneBtnTapped() {
        view.endEditing(true)
        let date = mondayEndTimePicker.date
        mondayEndTime.text = convertTimeFormater(date)
        OrganiserModel.data!.mondayEndTime = mondayEndTime.text
        updateOnFirebase(organiserModel: OrganiserModel.data!)
    }
    
    
    func createTuesdayStartTimePicker() {
        tuesdayStartTime.isUserInteractionEnabled = true
        tuesdayStartTimePicker.preferredDatePickerStyle = .wheels
        
   
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(tuesdayStartTimeDoneBtnTapped))
        toolbar.setItems([done], animated: true)
      
        tuesdayStartTime.inputAccessoryView = toolbar

        tuesdayStartTimePicker.datePickerMode = .time
        tuesdayStartTime.inputView = tuesdayStartTimePicker
    }
    @objc func tuesdayStartTimeDoneBtnTapped() {
        view.endEditing(true)
        let date = tuesdayStartTimePicker.date
        tuesdayStartTime.text = convertTimeFormater(date)
        
        OrganiserModel.data!.tuesdayStartTime = tuesdayStartTime.text
        updateOnFirebase(organiserModel: OrganiserModel.data!)
    }
    
    func createTuesdayEndTimePicker() {
        tuesdayEndTime.isUserInteractionEnabled = true
            tuesdayEndTimePicker.preferredDatePickerStyle = .wheels
     
   
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(tuesdayEndTimeDoneBtnTapped))
        toolbar.setItems([done], animated: true)
      
        tuesdayEndTime.inputAccessoryView = toolbar

        tuesdayEndTimePicker.datePickerMode = .time
        tuesdayEndTime.inputView = tuesdayEndTimePicker
    }
    @objc func tuesdayEndTimeDoneBtnTapped() {
        view.endEditing(true)
        let date = tuesdayEndTimePicker.date
        tuesdayEndTime.text = convertTimeFormater(date)
        
        OrganiserModel.data!.tuesdayEndTime = tuesdayEndTime.text
        updateOnFirebase(organiserModel: OrganiserModel.data!)
    }
    
    
    func createWednesdayStartTimePicker() {
        wednesdayStartTime.isUserInteractionEnabled = true
            wednesdayStartTimePicker.preferredDatePickerStyle = .wheels
     
   
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(wednesdayStartTimeDoneBtnTapped))
        toolbar.setItems([done], animated: true)
      
        wednesdayStartTime.inputAccessoryView = toolbar

        wednesdayStartTimePicker.datePickerMode = .time
        wednesdayStartTime.inputView = wednesdayStartTimePicker
    }
    @objc func wednesdayStartTimeDoneBtnTapped() {
        view.endEditing(true)
        let date = wednesdayStartTimePicker.date
        wednesdayStartTime.text = convertTimeFormater(date)
        
        OrganiserModel.data!.wednesdayStartTime = wednesdayStartTime.text
        updateOnFirebase(organiserModel: OrganiserModel.data!)
    }
    
    func createWednesdayEndTimePicker() {
        wednesdayEndTime.isUserInteractionEnabled = true
            wednesdayEndTimePicker.preferredDatePickerStyle = .wheels
        
   
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(wednesdayEndTimeDoneBtnTapped))
        toolbar.setItems([done], animated: true)
      
        wednesdayEndTime.inputAccessoryView = toolbar

        wednesdayEndTimePicker.datePickerMode = .time
        wednesdayEndTime.inputView = wednesdayEndTimePicker
    }
    @objc func wednesdayEndTimeDoneBtnTapped() {
        view.endEditing(true)
        let date = wednesdayEndTimePicker.date
        wednesdayEndTime.text = convertTimeFormater(date)
        
        OrganiserModel.data!.wednesdayEndTime = wednesdayEndTime.text
        updateOnFirebase(organiserModel: OrganiserModel.data!)
    }
    
    
    func createThursdayStartTimePicker() {
        thursdayStartTime.isUserInteractionEnabled = true
            thursdayStartTimePicker.preferredDatePickerStyle = .wheels
     
   
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(thursdayStartTimeDoneBtnTapped))
        toolbar.setItems([done], animated: true)
      
        thursdayStartTime.inputAccessoryView = toolbar

        thursdayStartTimePicker.datePickerMode = .time
        thursdayStartTime.inputView = thursdayStartTimePicker
    }
    @objc func thursdayStartTimeDoneBtnTapped() {
        view.endEditing(true)
        let date = thursdayStartTimePicker.date
        thursdayStartTime.text = convertTimeFormater(date)
        
        OrganiserModel.data!.thursdayStartTime = thursdayStartTime.text
        updateOnFirebase(organiserModel: OrganiserModel.data!)
    }
    
    func createThursdayEndTimePicker() {
        thursdayStartTime.isUserInteractionEnabled = true
            thursdayEndTimePicker.preferredDatePickerStyle = .wheels
        
   
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(thursdayEndTimeDoneBtnTapped))
        toolbar.setItems([done], animated: true)
      
        thursdayEndTime.inputAccessoryView = toolbar

        thursdayEndTimePicker.datePickerMode = .time
        thursdayEndTime.inputView = thursdayEndTimePicker
    }
    @objc func thursdayEndTimeDoneBtnTapped() {
        view.endEditing(true)
        let date = thursdayEndTimePicker.date
        thursdayEndTime.text = convertTimeFormater(date)
        
        OrganiserModel.data!.thursdayEndTime = thursdayEndTime.text
        updateOnFirebase(organiserModel: OrganiserModel.data!)
    }
    
    func createFridayStartTimePicker() {
        fridayStartTime.isUserInteractionEnabled = true
            fridayStartTimePicker.preferredDatePickerStyle = .wheels
       
   
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(fridayStartTimeDoneBtnTapped))
        toolbar.setItems([done], animated: true)
      
        fridayStartTime.inputAccessoryView = toolbar

        fridayStartTimePicker.datePickerMode = .time
        fridayStartTime.inputView = fridayStartTimePicker
    }
    @objc func fridayStartTimeDoneBtnTapped() {
        view.endEditing(true)
        let date = fridayStartTimePicker.date
        fridayStartTime.text = convertTimeFormater(date)
        
        OrganiserModel.data!.fridayStartTime = fridayStartTime.text
        updateOnFirebase(organiserModel: OrganiserModel.data!)
    }
    
    func createFridayEndTimePicker() {
        fridayEndTime.isUserInteractionEnabled = true
            fridayEndTimePicker.preferredDatePickerStyle = .wheels
        
   
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(fridayEndTimeDoneBtnTapped))
        toolbar.setItems([done], animated: true)
      
        fridayEndTime.inputAccessoryView = toolbar

        fridayEndTimePicker.datePickerMode = .time
        fridayEndTime.inputView = fridayEndTimePicker
    }
    @objc func fridayEndTimeDoneBtnTapped() {
        view.endEditing(true)
        let date = fridayEndTimePicker.date
        fridayEndTime.text = convertTimeFormater(date)
        
        OrganiserModel.data!.fridayEndTime = fridayEndTime.text
        updateOnFirebase(organiserModel: OrganiserModel.data!)
    }
    
    
    func createSaturdayStartTimePicker() {
        saturdayStartTime.isUserInteractionEnabled = true
        
            saturdayStartTimePicker.preferredDatePickerStyle = .wheels
       
   
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(saturdayStartTimeDoneBtnTapped))
        toolbar.setItems([done], animated: true)
      
        saturdayStartTime.inputAccessoryView = toolbar

        saturdayStartTimePicker.datePickerMode = .time
        saturdayStartTime.inputView = saturdayStartTimePicker
    }
    @objc func saturdayStartTimeDoneBtnTapped() {
        view.endEditing(true)
        let date = saturdayStartTimePicker.date
        saturdayStartTime.text = convertTimeFormater(date)
        
        OrganiserModel.data!.saturdayStartTime  = saturdayStartTime.text
        updateOnFirebase(organiserModel: OrganiserModel.data!)
    }
    
    func createSaturdayEndTimePicker() {
        saturdayEndTime.isUserInteractionEnabled = true
            saturdayEndTimePicker.preferredDatePickerStyle = .wheels
      
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(saturdayEndTimeDoneBtnTapped))
        toolbar.setItems([done], animated: true)
      
        saturdayEndTime.inputAccessoryView = toolbar

        saturdayEndTimePicker.datePickerMode = .time
        saturdayEndTime.inputView = saturdayEndTimePicker
    }
    @objc func saturdayEndTimeDoneBtnTapped() {
        view.endEditing(true)
        let date = saturdayEndTimePicker.date
        saturdayEndTime.text = convertTimeFormater(date)
        
        OrganiserModel.data!.saturdayEndTime  = saturdayEndTime.text
        updateOnFirebase(organiserModel: OrganiserModel.data!)
    }
    
    @objc func updateOnFirebase(organiserModel : OrganiserModel){
        
        try? Firestore.firestore().collection("Organisers").document(organiserModel.uid ?? "123").setData(from: organiserModel, merge: true)
    }
    
    func createSundayStartTimePicker() {
        sundayStartTime.isUserInteractionEnabled = true
            sundayStartTimePicker.preferredDatePickerStyle = .wheels
      
   
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(sundayStartTimeDoneBtnTapped))
        toolbar.setItems([done], animated: true)
      
        sundayStartTime.inputAccessoryView = toolbar

        sundayStartTimePicker.datePickerMode = .time
        sundayStartTime.inputView = sundayStartTimePicker
    }
    @objc func sundayStartTimeDoneBtnTapped() {
        view.endEditing(true)
        let date = sundayStartTimePicker.date
        sundayStartTime.text = convertTimeFormater(date)
        
        OrganiserModel.data!.sundayStartTime  = sundayStartTime.text
        updateOnFirebase(organiserModel: OrganiserModel.data!)
    }
    
    func createSundayEndTimePicker() {
        sundayEndTime.isUserInteractionEnabled = true
            sundayEndTimePicker.preferredDatePickerStyle = .wheels
        
   
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(sundayEndTimeDoneBtnTapped))
        toolbar.setItems([done], animated: true)
      
        sundayEndTime.inputAccessoryView = toolbar

        sundayEndTimePicker.datePickerMode = .time
        sundayEndTime.inputView = sundayEndTimePicker
    }
    @objc func sundayEndTimeDoneBtnTapped() {
        view.endEditing(true)
        let date = sundayEndTimePicker.date
        sundayEndTime.text = convertTimeFormater(date)
        
        OrganiserModel.data!.sundayEndTime  = sundayEndTime.text
        updateOnFirebase(organiserModel: OrganiserModel.data!)
    }
    
    @objc func backBtnClicked(){
        self.dismiss(animated: true)
    }
    
    @IBAction func mondayClicked(_ sender: Any) {
        mondayCheck.isSelected = !mondayCheck.isHidden
        OrganiserModel.data!.mondayAvailable = mondayCheck.isSelected
        self.updateOnFirebase(organiserModel: OrganiserModel.data!)
    }
    
    @IBAction func tuesdayClicked(_ sender: Any) {
        
        tuesdayCheck.isSelected = !tuesdayCheck.isSelected
        OrganiserModel.data!.tuesdayAvailable = tuesdayCheck.isSelected
        self.updateOnFirebase(organiserModel: OrganiserModel.data!)
    }
    @IBAction func wednesdayClicked(_ sender: Any) {
        wednesdayCheck.isSelected = !wednesdayCheck.isSelected
        OrganiserModel.data!.wednesdayAvailable = wednesdayCheck.isSelected
        self.updateOnFirebase(organiserModel: OrganiserModel.data!)
    }
    @IBAction func thursdayClicked(_ sender: Any) {
        thursdayCheck.isSelected = !thursdayCheck.isSelected
        OrganiserModel.data!.thursdayAvailable = thursdayCheck.isSelected
        self.updateOnFirebase(organiserModel: OrganiserModel.data!)
    }
    
    @IBAction func fridayClicked(_ sender: Any) {
        fridayCheck.isSelected = !fridayCheck.isSelected
        OrganiserModel.data!.fridayAvailable = fridayCheck.isSelected
        self.updateOnFirebase(organiserModel: OrganiserModel.data!)
    }
    
    @IBAction func saturdayClicked(_ sender: Any) {
        saturdaycheck.isSelected = !saturdaycheck.isSelected
        OrganiserModel.data!.saturdayAvailable = saturdaycheck.isSelected
        self.updateOnFirebase(organiserModel: OrganiserModel.data!)
    }
    
    @IBAction func sundayClicked(_ sender: Any) {
        sundayCheck.isSelected = !sundayCheck.isSelected
        OrganiserModel.data!.sundayAvailable = sundayCheck.isSelected
        self.updateOnFirebase(organiserModel: OrganiserModel.data!)
    }
    
}
extension  ManageAvailablityViewController : UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if   mondayStartTime == textField || mondayEndTime == textField ||
                tuesdayStartTime == textField || tuesdayEndTime == textField ||
                wednesdayStartTime == textField || wednesdayEndTime == textField ||
                thursdayStartTime == textField || thursdayStartTime == textField ||
                fridayStartTime == textField || fridayStartTime == textField ||
                saturdayStartTime == textField || saturdayStartTime == textField ||
                sundayStartTime == textField || sundayEndTime == textField
        {
            return false
        }
        
        return true
        
    }
}
