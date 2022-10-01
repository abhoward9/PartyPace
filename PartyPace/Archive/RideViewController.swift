//
//  ViewController.swift
//  PartyPace
//
//  Created by Andrew Howard on 6/27/21.
//

import UIKit
import CoreGPX
import MapKit

//class RideViewController: UIViewController {
//    var gpxRoute = GPXRoute()
//    var mapPoints = [CLLocationCoordinate2D]()
//    
//    @IBOutlet weak var URLfield: UITextField!
//    
//    @IBAction func loadLine(_ sender: Any) {
////        print(mapPoints)
////        let url = URL(string: URLfield.text!)
//        let url = URL(string: "https://ridewithgps.com/users/518136/routes.json")
//        guard let requestUrl = url else { fatalError() }
//
//        // Create URL Request
//        var request = URLRequest(url: requestUrl)
//
//        // Specify HTTP Method to use
//        request.httpMethod = "GET"
//        request.addValue("apikey", forHTTPHeaderField: "674d66d1")
//        request.addValue("version", forHTTPHeaderField: "2")
//        request.addValue("auth_token", forHTTPHeaderField: "b3a08a5799f1810825666a6e84913e18")
//        request.addValue("offset", forHTTPHeaderField: "0")
//        request.addValue("limit", forHTTPHeaderField: "2")
//
//        // Send HTTP Request
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            
//            // Check if Error took place
//            if let error = error {
//                print("Error took place \(error)")
//                return
//            }
//            
//            // Read HTTP Response Status code
//            if let response = response as? HTTPURLResponse {
//                print("Response HTTP Status code: \(response.statusCode)")
//            }
//            
//            // Convert HTTP Response Data to a simple String
//            if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                let decoder = JSONDecoder()
//  
//                if let jsonData = dataString.data(using: .utf8) {
//
//                    do {
//
//                        let welcome = try decoder.decode([UserRoute].self, from: jsonData)
//                        
//                        print(welcome[0].id)
//                        
//
//                        DispatchQueue.main.async {
//                            
//                            
//                            let polyline = MKPolyline(coordinates: self.mapPoints, count: self.mapPoints.count)
//                            
//                            self.mapView.addOverlay(polyline)
//                        }
//
//                    } catch {
//                        print(error)
//                    }
//                }
//            
//        }
//                }
//
//        task.resume()
//
//        
//
//    }
//    
//    @IBOutlet weak var mapView: MKMapView!
//    
//    override func viewDidLoad() {
//        mapView.delegate = self
//        super.viewDidLoad()
//        
//
//     
//    }
//}
//    
//    
//    extension RideViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//
//        if let routePolyline = overlay as? MKPolyline {
//            let renderer = MKPolylineRenderer(polyline: routePolyline)
//            renderer.strokeColor = UIColor.blue.withAlphaComponent(0.9)
//            renderer.lineWidth = 7
//            return renderer
//        }
//
//        return MKOverlayRenderer()
//    }
//    
//}


