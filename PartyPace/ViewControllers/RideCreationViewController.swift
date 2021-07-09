//
//  ViewController.swift
//  PartyPace
//
//  Created by Andrew on 6/17/21.
//

import UIKit
import CoreLocation
import MapKit
import FirebaseDatabase
import FirebaseFirestore

enum tireChoices: String, CaseIterable {
    case road
    case over32
    case over40
    case over48
    
}

enum paceChoices: String, CaseIterable {
    case party, noDrop, cat5, cat4, cat3, cat2, cat1
}

enum privacyChoices: String, CaseIterable {
    case publicRide
    case privateRide
    case groupRide
    case mutualFriends
    case friendsOfFriends
}


class RideCreationViewController: UIViewController {
    var ref: DatabaseReference!

    
    var rideDate: Date?
    var rideStartLocation, meetupLocation: CLLocationCoordinate2D?
    var rideEndLocation: CLLocation?
    var pace: paceChoices?
    var recommendedTireSize: tireChoices?
    var privacySetting: privacyChoices?
    
    @IBOutlet weak var rideTitleField: UITextField!
    @IBOutlet weak var tireSizeLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var rideMap: MiniMap!
    let db = Firestore.firestore()
    var counter = 0

    @IBAction func CreateRideButtonPressed(_ sender: Any) {
        
        counter += 1

        let newride = Ride(rideName: "hello", time: Date(), paceSetting: .cat1, tireRecommendation: .over32, privacySetting: .groupRide)
        
        db.collection("Routes").document("\(counter)").setData([ "ride1": "\(newride.StartTime)"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    @IBOutlet weak var pacePicker: UIPickerView!
    
    @IBOutlet weak var tireSizePicker: UIPickerView!
    @IBOutlet weak var privacyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
//        let xtireSizePicker = TireSizePicker()
        // Do any additional setup after loading the view.
        pacePicker.dataSource = self
        pacePicker.delegate = self
        tireSizePicker.dataSource = self
        tireSizePicker.delegate = self
        privacyPicker.dataSource = self
        privacyPicker.delegate = self
        rideMap.delegate = rideMap
        rideMap.loadRoute()
        
        ref = Database.database().reference()
       
        let date = Date()
        
//        db.collection("cities").document("LA").setData([
//            "name": "Los Angeles",
//            "state": "CA",
//            "country": "USA"
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
        


        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let location = sender.location(in: self.fullMapView)
//        let locCoord = self.fullMapView.convert(location, toCoordinateFrom: self.fullMapView)
        super.viewWillAppear(true)
        
        if let pointLocation = rideStartLocation {
            let placemark = MKPlacemark(coordinate: pointLocation)
    //        let annotation = MKPointAnnotation()
            
            rideMap.removeAnnotations(rideMap.annotations)
            rideMap.addAnnotation(placemark)
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapSegue" {
            let controller = segue.destination as! UINavigationController
        }
    }
    
    @IBAction func unwindToCreationView(_ sender: UIStoryboardSegue) {
        
    }


}

extension RideCreationViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pacePicker {
            return paceChoices.allCases.count

        } else if pickerView == tireSizePicker{
            return tireChoices.allCases.count

        } else if pickerView == privacyPicker{
            return privacyChoices.allCases.count
        }
        return 0

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pacePicker {
            return paceChoices.allCases[row].rawValue

        } else if pickerView == tireSizePicker{
            return tireChoices.allCases[row].rawValue

        } else if pickerView == privacyPicker{
            return privacyChoices.allCases[row].rawValue
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pacePicker {
            pace = paceChoices.allCases[row]
        } else if pickerView == tireSizePicker{
            recommendedTireSize = tireChoices.allCases[row]

        } else if pickerView == privacyPicker {
            privacySetting = privacyChoices.allCases[row]
        }
    
        
    }
    
}



