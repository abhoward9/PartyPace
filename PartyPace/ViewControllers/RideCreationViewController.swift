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
import FirebaseFirestoreSwift
import CoreGPX


class RideCreationViewController: UIViewController {
    var gpxRoute = GPXRoute()
    var mapPoints = [CLLocationCoordinate2D]()
    
    var RideStartLocation: CLLocation?
    var RideTitle: String?
    
    
    
    
    
    
    
    var authToken: String!
    
    //MARK: IBOutlets and Actions
    @IBOutlet weak var rideTitleField: UITextField!
    @IBOutlet weak var tireSizeLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var rideMap: MKMapView!
    
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    @IBOutlet weak var pacePicker: UIPickerView!
    
    @IBOutlet weak var tireSizePicker: UIPickerView!
    @IBOutlet weak var privacyPicker: UIPickerView!
    @IBOutlet weak var RideNameTextField: UITextField!
    let db = Firestore.firestore()
    
    var newride = RideWithUserPreferences()
    
    
    
    @IBAction func CreateRideButtonPressed(_ sender: Any) {
        
        
        if RideNameTextField.text == "" {
            newride.name = RideNameTextField.placeholder

        } else {
            newride.name = RideNameTextField.text
        }
//        newride.name = RideNameTextField.attributedText?.string
        newride.StartTime = dateTimePicker.date
        newride.coordinate = GeoPoint(latitude: (RideStartLocation?.coordinate.latitude)!, longitude: (RideStartLocation?.coordinate.longitude)!)
        
        let geocoder = CLGeocoder()
        
//        let location = CLLocation(latitude: newride.coordinate!.latitude, longitude: newride.coordinate!.longitude)
        
        geocoder.reverseGeocodeLocation(CLLocation(latitude: RideStartLocation!.coordinate.latitude, longitude: RideStartLocation!.coordinate.longitude)) { placemarks, error in
            if let error = error {
                print(error)
            } else {
                
                let zipCode = placemarks![0].postalCode!
                
                let subZip = zipCode.dropLast(2)
//                var ref: DocumentReference? = nil
                
                
                
                
                
                
                do {
                    
                    let now = Calendar.current.dateComponents(in: .current, from: Date())
                    print(now.date)
                    try self.db.collection("Routes").document("\(subZip)").collection("\(zipCode)").document("\(now.day)\(now.month!)\(now.day)+\(now.hour)+\(now.minute)+\(now.second)+\(now.nanosecond)").setData(from: self.newride)
                } catch let error {
                    print("Error writing city to Firestore: \(error)")
                }
                
                
            }
        }
    }
    
    var ref: DatabaseReference!
    
    
    var rideDate: Date?
    var rideStartLocation, meetupLocation: CLLocationCoordinate2D?
    var rideEndLocation: CLLocation?
    var pace: paceChoices?
    var recommendedTireSize: tireChoices?
    var privacySetting: privacyChoices?
    
    
    //    let sharableRide = RideWithUserPreferences()
//    var counter = 0
    
    
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let now = Calendar.current.dateComponents(in: .current, from: Date())

        // Create the start of the day in `DateComponents` by leaving off the time.
//        let today = DateComponents(year: now.year, month: now.month, day: now.day)
//        let dateToday = Calendar.current.date(from: today)!
//        print(dateToday.timeIntervalSince1970)

        // Add 1 to the day to get tomorrow.
        // Don't worry about month and year wraps, the API handles that.
        let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + 1, hour: 9)
        
        let dateTomorrow = Calendar.current.date(from: tomorrow)!
        print(dateTomorrow.timeIntervalSince1970)
        

        dateTimePicker.date = dateTomorrow
        
        
        pacePicker.dataSource = self
        pacePicker.delegate = self
        tireSizePicker.dataSource = self
        tireSizePicker.delegate = self
        privacyPicker.dataSource = self
        privacyPicker.delegate = self
        rideMap.delegate = self
        _ = loadLatestRoutefromRWGPS()
        
        RideNameTextField.placeholder = RideTitle
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        if let pointLocation = rideStartLocation {
            let placemark = MKPlacemark(coordinate: pointLocation)
            
            rideMap.removeAnnotations(rideMap.annotations)
            rideMap.addAnnotation(placemark)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapSegue" {
            _ = segue.destination as! UINavigationController
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
        
        
        switch pickerView {
        case pacePicker:
            return paceChoices.allCases.count
        case tireSizePicker:
            return tireChoices.allCases.count
        case privacyPicker:
            return privacyChoices.allCases.count
        default: return 0
            
        }
        
        
        
        
        //        if pickerView == pacePicker {
        //            return paceChoices.allCases.count
        //
        //        } else if pickerView == tireSizePicker{
        //            return tireChoices.allCases.count
        //
        //        } else if pickerView == privacyPicker{
        //            return privacyChoices.allCases.count
        //        }
        //        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case pacePicker:
            pace = paceChoices.allCases[row]
            newride.ridePace = pace
            return paceChoices.allCases[row].rawValue
        case tireSizePicker:
            recommendedTireSize = tireChoices.allCases[row]
            newride.minTire = recommendedTireSize
            return tireChoices.allCases[row].rawValue
        case privacyPicker:
            privacySetting = privacyChoices.allCases[row]
            newride.ridePrivacy = privacySetting
            return privacyChoices.allCases[row].rawValue
        default: return ""
            
        }
        
        //        if pickerView == pacePicker {
        //            return paceChoices.allCases[row].rawValue
        //
        //        } else if pickerView == tireSizePicker{
        //            return tireChoices.allCases[row].rawValue
        //
        //        } else if pickerView == privacyPicker{
        //            return privacyChoices.allCases[row].rawValue
        //        }
        //        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case pacePicker:
            pace = paceChoices.allCases[row]
            newride.ridePace = pace
        case tireSizePicker:
            recommendedTireSize = tireChoices.allCases[row]
            newride.minTire = recommendedTireSize
        case privacyPicker:
            privacySetting = privacyChoices.allCases[row]
            newride.ridePrivacy = privacySetting
        default: return
            
        }
        
        
        
        
    }
    
}

















































//                    try self.db.collection("Routes").document("\(subZip)").collection("\(zipCode)").document("\(NSDate.now)").setData(from: shareRoute)

//                            ["name": "\(newride.StartTime)",
//                    "route": "\(newride.minTire?.rawValue)"])
//                { err in
//                    if let err = err {
//                        print("Error adding document: \(err)")
//                    } else {
//                        print("Document added with ID: \(ref!.documentID)")
//                            }
//                        }
//                self.db.collection("Routes").document("\(subZip)").collection("\(zipCode)").document("97203").setData([ "test": "\(newride.StartTime!)"]) { err in
//                    if let err = err {
//                        print("Error writing document: \(err)")
//                    } else {
//                        print("Document successfully written!")
//                    }
//                }


//            }
//        }

//        db.collection("Routes").document("\(9000)").setData([ "ride1": "\(newride.StartTime)"
