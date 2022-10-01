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
    
    @IBOutlet weak var LocalRidesTableView: UITableView!
    let locationManager = CLLocationManager()
    var ridesInArea = [RideWithUserPreferences]()
    var selectedRow: Int?
    
    private let refreshControl = UIRefreshControl()
//    @IBAction func FindRidesButtonPressed(_ sender: Any) {
//
//
//        let rides = findRides(_:)
//    }
    
   
    @objc private func findRides(_ Sender: Any) {
        
        let db = Firestore.firestore()
        
        
        locationManager.requestLocation()
        let currentLocation = locationManager.location
        //        print(currentLocation?.coordinate)
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
                        self.ridesInArea.removeAll()
                        for document in querySnapshot!.documents {
                            //                                print("\(document.documentID) => \(document.data())")
                            
                            document.reference.getDocument { (document, error) in
                                
                                let result = Result {
                                    try document?.data(as: RideWithUserPreferences.self)
                                }
                                switch result {
                                case .success(let ride):
                                    if let ride = ride {
                      
                                        self.ridesInArea.append(ride)
                                        self.LocalRidesTableView.reloadData()
                                        self.refreshControl.endRefreshing()
                                        
                                    } else {
                                        // A nil value was successfully initialized from the DocumentSnapshot,
                                        // or the DocumentSnapshot was nil.
                                        print("Document does not exist")
                                    }
                                case .failure(let error):
                                    // A `City` value could not be initialized from the DocumentSnapshot.
                                    print("Error decoding city: \(error)")
                                }
                            }
                            
                        }
                        
                        
                    }
                }
                //
                
                
            }
        }
        
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocalRidesTableView.delegate = self
        LocalRidesTableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        //        locationManager.stopUpdatingLocation()
        let rides = findRides(_:)
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            LocalRidesTableView.refreshControl = refreshControl
        } else {
            LocalRidesTableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(findRides(_:)), for: .valueChanged)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailViewSegue" {
            if let destVC = segue.destination as? RideDetailViewController {
//                let targetController = destVC.topViewController as? ReceiveViewController {
//                targetController.data = "hello from ReceiveVC !"
                destVC.DisplayedRide = ridesInArea[selectedRow!]
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location updated")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get users location.")
    }
}


extension FindPartyPaceRidesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(ridesInArea.count)
        return ridesInArea.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        
//        let cell = LocalRidesTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//        // set the text from the data model
        print(ridesInArea.count)

        let cell = tableView.dequeueReusableCell(withIdentifier: "LocalRideCell", for: indexPath) as! LocalRideCell
        cell.textLabel?.text = self.ridesInArea[indexPath.row].name

//            let country = countries[indexPath.row]
//            cell.countryTitleLabel?.text = country.name
//        cell.countryTextLabel?.text = country.isoCode
//        cell.countryImageView?.image = UIImage(named: country.isoCode)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedRow = indexPath.row
        performSegue(withIdentifier: "detailViewSegue", sender: UITapGestureRecognizer.self)

    }
    
    
    
    
}

class LocalRideCell: UITableViewCell {
    
    
}

