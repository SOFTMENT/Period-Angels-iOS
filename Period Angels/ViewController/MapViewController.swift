//
//  MapViewController.swift
//  Period Angels
//
//  Created by Vijay Rathore on 03/01/23.
//

import UIKit
import CoreLocation
import GeoFire
import Firebase

class MapViewController : UIViewController {
    var locationManager : CLLocationManager!
    @IBOutlet weak var mapView: MKMapView!
    let radiusInM: Double = 2000 * 1000
    var i = 0;
    override func viewDidLoad() {
        
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        mapView.delegate = self
    }
    
    
    func loadAnotation() {
        var i = 0
        for model in OrganiserModel.organisationModel {
            let annotation =  CustomAnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: model.latitude ?? 0.0, longitude: model.longitude ?? 0.0)
            annotation.title = model.name ?? "Featured Location"
            annotation.position = i
       
            mapView.addAnnotation(annotation)
            if i == (OrganiserModel.organisationModel.count - 1) {
                let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters:6000,longitudinalMeters: 6000)
                mapView.setRegion(region, animated: true)
                
            }
            
            i = i + 1
        }
        
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "map_OrganiserSeg" {
            if let vc = segue.destination as? ShowOrganisersDetailsViewController {
                if let organiserModel = sender as? OrganiserModel {
                    vc.organiserModel = organiserModel
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    
         
        
         switch status {
         case .notDetermined, .restricted, .denied:
    
             self.showSnack(messages: "Enable Location Permission")
         case .authorizedAlways, .authorizedWhenInUse:
            
             locationManager.startUpdatingLocation()
         @unknown default:
             print("ERROR")
         }
     
    
    }
    
    func getAllOrganisers(){
    
        ProgressHUDShow(text: "")
        let center = CLLocationCoordinate2D(latitude: Constants.latitude, longitude: Constants.longitude)
      
        let queryBounds = GFUtils.queryBounds(forLocation: center,
                                              withRadius: radiusInM)
        
        
        var queries : [Query]!
        
      
         
            queries = queryBounds.map { bound -> Query in
              
                return Firestore.firestore().collection("Organisers")
                    .order(by: "geoHash")
                    .start(at: [bound.startValue])
                    .end(at: [bound.endValue])
            }
        

        
        OrganiserModel.organisationModel.removeAll()
     
        
        for query in queries {
           
            query.getDocuments(completion: getDocumentsCompletion)
        }
      
      
        self.ProgressHUDHide()
    }
    func getDocumentsCompletion(snapshot: QuerySnapshot?, error: Error?) -> () {
       
        guard let documents = snapshot?.documents else {
            self.showError(error!.localizedDescription)
            return
        }
        
        
       
        for document in documents {
            
            let lat = document.data()["latitude"] as? Double ?? 0
            let lng = document.data()["longitude"] as? Double ?? 0
         
            let coordinates = CLLocation(latitude: lat, longitude: lng)
            let centerPoint = CLLocation(latitude: Constants.latitude, longitude: Constants.longitude)
            
            // We have to filter out a few false positives due to GeoHash accuracy, but
            // most will match
            let distance = GFUtils.distance(from: centerPoint, to: coordinates)
            if distance <= radiusInM {
                if let organiserModel = try? document.data(as: OrganiserModel.self) {
                    
                  
                    OrganiserModel.organisationModel.removeAll { organiser in
                        if organiser.uid == organiserModel.uid {
                            return true
                        }
                       return false
                    }
                    
                    OrganiserModel.organisationModel.append(organiserModel)
                    
                }
            }
        }
        
        OrganiserModel.organisationModel.sort { organiser1, organiser2 in
            
            let coordinate1 = CLLocation(latitude: organiser1.latitude ?? 0.0, longitude: organiser1.longitude ?? 0.0)
            let coordinate2 = CLLocation(latitude: Constants.latitude, longitude: Constants.longitude)
            let distanceKM1 =  (coordinate1.distance(from: coordinate2)) / 1000.0
            
            let coordinate3 = CLLocation(latitude: organiser2.latitude ?? 0.0, longitude: organiser2.longitude ?? 0.0)
            let distanceKM2 =  (coordinate3.distance(from: coordinate2)) / 1000.0
            
            if distanceKM1 > distanceKM2 {
                return true
            }
            return false
        }
        
        self.loadAnotation()
        
    
       
    }
}

extension MapViewController : CLLocationManagerDelegate {
    
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let userLocation = locations[0] as CLLocation
        Constants.latitude = userLocation.coordinate.latitude
        Constants.longitude = userLocation.coordinate.longitude
        
        
        self.getAllOrganisers()
        
        if i >= 3 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            locationManager = nil
        }
        
        i = i + 1
       
       
        }
        
    }

class CustomAnotation : MKPointAnnotation {
    
    var position : Int = 0
    
}
extension MapViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation {
            
            
            if let customAnotation  = annotation as? CustomAnotation {
              
                let model = OrganiserModel.organisationModel[customAnotation.position]
                performSegue(withIdentifier: "map_OrganiserSeg", sender: model)
                
            }
           
            
        }
        
    }
}
