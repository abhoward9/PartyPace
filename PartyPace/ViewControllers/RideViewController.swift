//
//  ViewController.swift
//  PartyPace
//
//  Created by Andrew Howard on 6/27/21.
//

import UIKit
import CoreGPX
import MapKit

class RideViewController: UIViewController {
    var gpxRoute = GPXRoute()
    var mapPoints = [CLLocationCoordinate2D]()
    
    @IBOutlet weak var URLfield: UITextField!
    
    @IBAction func loadLine(_ sender: Any) {
//        print(mapPoints)
        let url = URL(string: URLfield.text!)
//        let url = URL(string: "https://ridewithgps.com/routes/141014.json")
        guard let requestUrl = url else { fatalError() }

        // Create URL Request
        var request = URLRequest(url: requestUrl)
//        let queryItem1 = URLQueryItem(name: "apikey", value: "testkey1")
//        let queryItem2 = URLQueryItem(name: "version", value: "2")
//        let queryItem3 = URLQueryItem(name: "auth_token", value: "942927bd9e0b862a129ce34bb7824b6f")
        
//        let queryItems = [queryItem1, queryItem2, queryItem3]
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        request.addValue("apikey", forHTTPHeaderField: "testkey1")
        request.addValue("version", forHTTPHeaderField: "2")
        request.addValue("auth_token", forHTTPHeaderField: "942927bd9e0b862a129ce34bb7824b6f")

        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                let decoder = JSONDecoder()
  
                if let jsonData = dataString.data(using: .utf8) {

                    do {
                        let route = try decoder.decode(Route.self, from: jsonData)
                        
                        
                        for point in route.trackPoints {
//                            print(point)
                            let routePoint = GPXRoutePoint(latitude: point.y, longitude: point.x)
                            self.gpxRoute.points.append(routePoint)
//                            print(routePoint.latitude, routePoint.longitude)
                            self.mapPoints.append(CLLocationCoordinate2D(latitude: routePoint.latitude!, longitude: routePoint.longitude!))
                            
                            
                        }
                        DispatchQueue.main.async {
                            
                        
                        let polyline = MKPolyline(coordinates: self.mapPoints, count: self.mapPoints.count)
                //        mapView.addOverlay(polyline)
                //        let render = MKPolylineRenderer(polyline: polyline)
                        self.mapView.addOverlay(polyline)
                        }

                    } catch {
                        print(error)
                    }
                }
            
        }
                }

        task.resume()
//        let polyline = MKPolyline(coordinates: self.mapPoints, count: self.mapPoints.count)
////        mapView.addOverlay(polyline)
////        let render = MKPolylineRenderer(polyline: polyline)
//        self.mapView.addOverlay(polyline)
        

    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        mapView.delegate = self
        super.viewDidLoad()
        

     
    }
}
    
    
    extension RideViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = UIColor.blue.withAlphaComponent(0.9)
            renderer.lineWidth = 7
            return renderer
        }

        return MKOverlayRenderer()
    }
    
}


