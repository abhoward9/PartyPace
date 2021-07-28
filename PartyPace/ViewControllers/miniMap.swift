//
//  miniMap.swift
//  PartyPace
//
//  Created by Andrew Howard on 7/5/21.
//

import Foundation
import MapKit
import CoreGPX

//struct PartyPaceRoute {
//    var RideStartLocation: CLLocation?
//
//}

extension RideCreationViewController: MKMapViewDelegate {
    
    
    
    
 
   //tries to load the latest RWGPS route and gets the ID of that route
    
    func loadLatestRoutefromRWGPS() -> Int? {
        let group = DispatchGroup()
        let userID = defaults.integer(forKey: "RWGPSCurrentUserID")
        var latestRouteID: Int?

        var numberOfUserRoutes: Int?
            group.enter()
        let request = getNumberOfUserRoutesURLRequest(userID: userID)
            
            // Send HTTP Request and set number of routes
            let task = URLSession.shared.dataTask(with: request!) { (data, response, error) in
                
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
                        //                                        print(dataString)
                        do {
                            let userRoutes = try decoder.decode(UserRoutes.self, from: jsonData)
                            
//                            identifier = userRoutes.results[0].id
                            
                            numberOfUserRoutes = userRoutes.resultsCount

                            group.leave()
                            
                            DispatchQueue.main.async {
            
            

                                            }
            
                                        } catch {
                                            print(error)
                                        }
                                    }
            
                                }
                            }
                            task.resume()

//                }
        group.notify(queue: .main) {
            let group2 = DispatchGroup()

    
                group2.enter()
                var request = getIDOfLatestRoute(numberOfRoutes: numberOfUserRoutes!, userID: userID)
            print(request)
            // Send HTTP Request
            let task = URLSession.shared.dataTask(with: request!) { (data, response, error) in
                
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
                    print(dataString)
                    if let jsonData = dataString.data(using: .utf8) {
                        print(dataString)
                        do {
                            let latestUserRoute = try decoder.decode(UserRoutes.self, from: jsonData)
                            
                            latestRouteID = latestUserRoute.results[0].id
                            
                            
                            
                            
                            group2.leave()
                            
                            DispatchQueue.main.async {
                                
                                
                            }
                            
                        } catch {
                            print(error)
                        }
                    }
                    
                }
            }
            task.resume()
            
            group2.notify(queue: .main) { [self] in
                self.requestRouteDetailsAndDisplayRoute(identifier: latestRouteID)
            
            
                }

                    }
            return latestRouteID
        }
    
    

    
    
    fileprivate func displayRouteOnMap(userRoutes: Results) {
        let boundingBox = userRoutes.route.boundingBox
        self.RideNameTextField.placeholder = self.RideTitle
        let polyline = MKPolyline(coordinates: self.mapPoints, count: self.mapPoints.count)
        //                            self.addOverlay(polyline)
        let render = MKPolylineRenderer(polyline: polyline)
        self.rideMap.addOverlay(polyline)
        //                            self.addOverlay(polyline)
        self.rideMap.addOverlay(polyline)
        self.RideStartLocation = CLLocation(latitude: userRoutes.route.firstLatitudePoint, longitude: userRoutes.route.firstLongitudePoint)
        
        let height = (boundingBox[1].lng + boundingBox[0].lng)/2
        let width = (boundingBox[1].lat + boundingBox[0].lat)/2
        
        let coordinate0 = CLLocation(latitude: boundingBox[1].lat, longitude: boundingBox[1].lng)
        let coordinate1 = CLLocation(latitude: boundingBox[0].lat, longitude: boundingBox[0].lng)
        
        let distanceInMeters = coordinate0.distance(from: coordinate1) // result is in meters
        
        let camera = MKMapCamera(lookingAtCenter: CLLocationCoordinate2D(latitude: width, longitude: height), fromEyeCoordinate: CLLocationCoordinate2D(latitude: width, longitude: height), eyeAltitude: CLLocationDistance(distanceInMeters*1.5))
        self.rideMap.setCamera(camera, animated: true)
    }
    
    fileprivate func requestRouteDetailsAndDisplayRoute(identifier: Int?) {
        var request = createUserRouteDetailsRequest(routeID: identifier!)
        
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request!) { (data, response, error) in
            
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
//                    print(dataString)
                    do {
                        let userRoutes = try decoder.decode(Results.self, from: jsonData)
//                        print(userRoutes)
                        self.RideTitle = userRoutes.route.name
                        


                        for point in userRoutes.route.trackPoints {
                            let routePoint = GPXRoutePoint(latitude: point.y, longitude: point.x)
                            self.gpxRoute.points.append(routePoint)
                            self.mapPoints.append(CLLocationCoordinate2D(latitude: routePoint.latitude!, longitude: routePoint.longitude!))

                        }
                        self.userRoutesResults = userRoutes

                        
//                        let boundingBox = userRoutes.route.boundingBox

                        DispatchQueue.main.async {
                            
                            self.displayRouteOnMap(userRoutes: userRoutes)
//                            return partyPaceRoute
                            
                        }
                        
                    } catch {
                        print(error)
                    }
                }
                
            }
        }
        task.resume()
    }
    
    

    
    
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
