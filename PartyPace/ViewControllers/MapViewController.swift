//
//  MapViewController.swift
//  PartyPace
//
//  Created by Andrew on 6/20/21.
//
import MapKit
import CoreLocation
import UIKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var longPressLocation: CLLocationCoordinate2D?
    @IBOutlet weak var fullMapView: MKMapView!
    @IBOutlet weak var meetupLocationButton: UIButton!
    
    
    fileprivate func setupMapView() {
        let locationManager = CLLocationManager()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        
        //Zoom to user location
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 20000, longitudinalMeters: 20000)
            fullMapView.setRegion(viewRegion, animated: false)
        }
        
        
        DispatchQueue.main.async {
            locationManager.startUpdatingLocation()
        }
        
        // Do any additional setup after loading the view.
        fullMapView.isUserInteractionEnabled = true
        locationManager.delegate = self
        
        locationManager.requestLocation()
        fullMapView.showsUserLocation = true
        longPressLocation = locationManager.location?.coordinate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        
        meetupLocationButton.layer.cornerRadius = 5
        meetupLocationButton.layer.borderWidth = 1
        meetupLocationButton.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func mapLongPressed(_ sender: UILongPressGestureRecognizer) {
        let location = sender.location(in: self.fullMapView)
        let locCoord = self.fullMapView.convert(location, toCoordinateFrom: self.fullMapView)
        
        let placemark = MKPlacemark(coordinate: locCoord)
//        let annotation = MKPointAnnotation()
        fullMapView.showsUserLocation = false

        fullMapView.removeAnnotations(fullMapView.annotations)
        self.fullMapView.addAnnotation(placemark)
        longPressLocation = locCoord
        
        
    }

// MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let controller = segue.destination as? RideCreationViewController {
            controller.meetupLocation = longPressLocation
        }
//        controller.meetupLocation = CLLocationCoordinate2D()
//        controller.meetupLocation? = longPressLocation!
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }

}
