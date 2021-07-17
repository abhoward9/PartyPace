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



class RideCreationViewController: UIViewController {
    var authToken: String!
    
    //MARK: IBOutlets and Actions
    @IBOutlet weak var rideTitleField: UITextField!
    @IBOutlet weak var tireSizeLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var rideMap: MiniMap!
    
    @IBOutlet weak var pacePicker: UIPickerView!
    
    @IBOutlet weak var tireSizePicker: UIPickerView!
    @IBOutlet weak var privacyPicker: UIPickerView!
    
    @IBAction func CreateRideButtonPressed(_ sender: Any) {
        
        counter += 1

        let newride = RideWithUserPreferences(rideName: "hello", time: Date(), paceSetting: .cat1, tireRecommendation: .over32, privacySetting: .groupRide)
        
        db.collection("Routes").document("\(counter)").setData([ "ride1": "\(newride.StartTime)"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    @IBAction func GetRideButtonPressed(_ sender: Any) {
        
                    
        
        
    }
    var ref: DatabaseReference!

    
    var rideDate: Date?
    var rideStartLocation, meetupLocation: CLLocationCoordinate2D?
    var rideEndLocation: CLLocation?
    var pace: paceChoices?
    var recommendedTireSize: tireChoices?
    var privacySetting: privacyChoices?
    

    let db = Firestore.firestore()
    var counter = 0

    
    
    
    

    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
//        let xtireSizePicker = TireSizePicker()
        pacePicker.dataSource = self
        pacePicker.delegate = self
        tireSizePicker.dataSource = self
        tireSizePicker.delegate = self
        privacyPicker.dataSource = self
        privacyPicker.delegate = self
        rideMap.delegate = rideMap
        rideMap.loadRoute()

        
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



