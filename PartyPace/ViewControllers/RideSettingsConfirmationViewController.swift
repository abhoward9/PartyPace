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


class RideSettingsConfirmationViewController: superClass {
//    var gpxRoute = GPXRoute()
//    var mapPoints = [CLLocationCoordinate2D]()
//
    var RideStartLocation: CLLocation?
//    var RideTitle: String?
//
//
//    var userRoutesResults: Results?
    
    
    
//    @IBAction func meetuplocationpressed(_ sender: Any) {
//        print(meetupLocation)
//    }
    
    var authToken: String!
    
    //MARK: IBOutlets and Actions
    @IBOutlet weak var rideTitleField: UITextField!
    @IBOutlet weak var tireSizeLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
//    @IBOutlet weak var fullMapView: MKMapView!
    
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    @IBOutlet weak var pacePicker: UIPickerView!
    
    @IBOutlet weak var tireSizePicker: UIPickerView!
    @IBOutlet weak var privacyPicker: UIPickerView!
    @IBOutlet weak var RideNameTextField: UITextField!
    let db = Firestore.firestore()
    
    var newride = RideWithUserPreferences()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:)))
        fullMapView.addGestureRecognizer(tapGestureRecognizer)
        let now = Calendar.current.dateComponents(in: .current, from: Date())

        // Create the start of the day in `DateComponents` by leaving off the time.
//        let today = DateComponents(year: now.year, month: now.month, day: now.day)
//        let dateToday = Calendar.current.date(from: today)!
//        print(dateToday.timeIntervalSince1970)

        // Add 1 to the day to get tomorrow.
        // Don't worry about month and year wraps, the API handles that.
        let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + 1, hour: 9)
        
        let dateTomorrow = Calendar.current.date(from: tomorrow)!
     

        dateTimePicker.date = dateTomorrow
        
        
        pacePicker.dataSource = self
        pacePicker.delegate = self
        tireSizePicker.dataSource = self
        tireSizePicker.delegate = self
        privacyPicker.dataSource = self
        privacyPicker.delegate = self
        fullMapView.delegate = self
        
        if let authToken = defaults.string(forKey: "RWGPSAuthKey") {
        _ = loadLatestRoutefromRWGPS()

//            RideNameTextField.placeholder = RideTitle

        }
        
        
        
        
    }

    
    @IBAction func CreateRideButtonPressed(_ sender: Any) {
        
        let geocoder = CLGeocoder()

        if RideNameTextField.text == "" {
            newride.name = RideNameTextField.placeholder

        } else {
            newride.name = RideNameTextField.text
        }
//        newride.name = RideNameTextField.attributedText?.string
        newride.StartTime = dateTimePicker.date
        newride.coordinate = GeoPoint(latitude: (RideStartLocation?.coordinate.latitude)!, longitude: (RideStartLocation?.coordinate.longitude)!)
        
        
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
    
    
    @IBAction func didTapImageView(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "fullMapViewSegue", sender: UITapGestureRecognizer.self)
        }

    
    

    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        print(meetupLocation)
        if let pointLocation = rideStartLocation {
            let meetupPointPlacemark = MKPlacemark(coordinate: pointLocation)
            
            fullMapView.removeAnnotations(fullMapView.annotations)
            fullMapView.addAnnotation(meetupPointPlacemark)
        }
        
        if let authToken = defaults.string(forKey: "RWGPSAuthKey") {
        _ = loadLatestRoutefromRWGPS()
            RideNameTextField.placeholder = RideTitle

        }
        
    }
    

    
    @IBAction func unwindToCreationView(_ sender: UIStoryboardSegue) {

        let placemark = MKPlacemark(coordinate: meetupLocation!)
        fullMapView.removeAnnotations(fullMapView.annotations)
        fullMapView.addAnnotation(placemark)
        
        //sets the meetup location 
        if let meetupLocation = meetupLocation {
            newride.meetupLocation = GeoPoint(latitude: meetupLocation.latitude, longitude: meetupLocation.longitude)
        }
    }
    
}
