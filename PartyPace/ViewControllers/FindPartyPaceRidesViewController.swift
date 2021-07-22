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
    var ridesInArea = [RideWithUserPreferences]()
    @IBAction func FindRidesButtonPressed(_ sender: Any) {
        
        
        findRides()
    }
    
//    enum FireStoreQueryResult<Value> {
//        case success(Value)
//        case failure(Error)
//    }
    
    func findRides() {
        
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
                                            // A `City` value was successfully initialized from the DocumentSnapshot.
                                            self.ridesInArea.append(ride)
                                            self.LocalRidesTableView.reloadData()

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

        LocalRidesTableView.delegate = self
        LocalRidesTableView.dataSource = self

                locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()
                locationManager.requestLocation()
//        locationManager.stopUpdatingLocation()
        findRides()
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


extension FindPartyPaceRidesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ridesInArea.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one

        let cell = LocalRidesTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                
                // set the text from the data model
        cell.textLabel?.text = self.ridesInArea[indexPath.row].ridePace?.rawValue
                
                return cell
    }
    
    
    
    
}

class cell: UITableViewCell {
    
}

