//
//  MapViewController.swift
//  PartyPace
//
//  Created by Andrew on 6/20/21.
//
import MapKit
import CoreLocation
import UIKit

class MapViewController: UIViewController {
    
    var longPressLocation: CLLocationCoordinate2D?
    @IBOutlet weak var fullMapView: MKMapView!
    @IBAction func mapLongPressed(_ sender: UILongPressGestureRecognizer) {
        let location = sender.location(in: self.fullMapView)
        let locCoord = self.fullMapView.convert(location, toCoordinateFrom: self.fullMapView)
        
        let placemark = MKPlacemark(coordinate: locCoord)
//        let annotation = MKPointAnnotation()
        
        fullMapView.removeAnnotations(fullMapView.annotations)
        self.fullMapView.addAnnotation(placemark)
        longPressLocation = locCoord
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

// MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let controller = segue.destination as! RideCreationViewController
        controller.rideStartLocation = CLLocationCoordinate2D()
        controller.rideStartLocation? = longPressLocation!
        
    }


}
