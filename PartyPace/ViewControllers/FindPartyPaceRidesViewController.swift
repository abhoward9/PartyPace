//
//  FindPartyPaceRidesViewController.swift
//  PartyPace
//
//  Created by Andrew Howard on 7/18/21.
//

import UIKit
import CoreLocation
import FirebaseDatabase
import FirebaseFirestore

class FindPartyPaceRidesViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBAction func FindRidesButtonPressed(_ sender: Any) {
        
        
        findRides()
    }
    
    func findRides() {

        let db = Firestore.firestore()
        

        locationManager.requestLocation()
        let currentLocation = locationManager.location
        print(currentLocation?.coordinate)
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(currentLocation!) { placemarks, error in
                if let error = error {
                    print(error)
                } else {
                    
                    let zipCode = placemarks![0].postalCode!
                    
                    let subZip = zipCode.dropLast(2)
                    var ref: DocumentReference? = nil
                    
                    let docRef = db.collection("Routes").document("\(subZip)").collection("\(zipCode)").getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            for document in querySnapshot!.documents {
                                print("\(document.documentID) => \(document.data())")
                            }
                        }
                    }
    //                self.db.collection("Routes").document("\(subZip)").collection("\(zipCode)").document("97203").setData([ "test": "\(newride.StartTime!)"]) { err in
    //                    if let err = err {
    //                        print("Error writing document: \(err)")
    //                    } else {
    //                        print("Document successfully written!")
    //                    }
    //                }
                    
                    
                }
            }
        
        
//        let docRef = db.collection("Routes").document("972").collection("97203").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
//        }

//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document data: \(dataDescription)")
//            } else {
//                print("Document does not exist")
//            }
//        }
            
        
    }
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()

                locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()
                locationManager.requestLocation()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location updated")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Failed to get users location.")
        }
}
