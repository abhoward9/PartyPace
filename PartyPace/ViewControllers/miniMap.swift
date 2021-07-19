//
//  miniMap.swift
//  PartyPace
//
//  Created by Andrew Howard on 7/5/21.
//

import Foundation
import MapKit
import CoreGPX

struct PartyPaceRoute {
    var RideStartLocation: CLLocation?
    
    
}

class MiniMap: MKMapView {
    var gpxRoute = GPXRoute()
    var mapPoints = [CLLocationCoordinate2D]()
    
    var partyPaceRoute = PartyPaceRoute()
    
 
   
    
    func loadRoute() {
        let group = DispatchGroup()
        let userID = 518136
        var latestRouteID: Int?

//        let urls = [
//            URL(string: userRoutes()),
//        ]
        var numberOfUserRoutes: Int?
//        var identifier: Int?
//        for url in urls {
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
            
        }
    
    
//    fileprivate func requestRouteDetail(identifier: Int?) {
//        var request = createUserRouteDetailsRequest(routeID: identifier!)
//
//        // Send HTTP Request
//        let task = URLSession.shared.dataTask(with: request!) { (data, response, error) in
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
////                    print(dataString)
//                    do {
//                        let userRoutes = try decoder.decode(Results.self, from: jsonData)
//
////                        print(userRoutes)
//
//                        for point in userRoutes.route.trackPoints {
//                            let routePoint = GPXRoutePoint(latitude: point.y, longitude: point.x)
//                            self.gpxRoute.points.append(routePoint)
//                            self.mapPoints.append(CLLocationCoordinate2D(latitude: routePoint.latitude!, longitude: routePoint.longitude!))
//
//                        }
//
//                        let boundingBox = userRoutes.route.boundingBox
//                        DispatchQueue.main.async {
//
//
//                            let polyline = MKPolyline(coordinates: self.mapPoints, count: self.mapPoints.count)
////                            self.addOverlay(polyline)
//                            let render = MKPolylineRenderer(polyline: polyline)
//                            self.addOverlay(polyline)
//
//                            let width = boundingBox[1].lng - boundingBox[0].lng
//                            let height = boundingBox[1].lat - boundingBox[0].lat
//
//                            let mapRect = MKMapRect(x: boundingBox[0].lat, y: boundingBox[0].lng, width: width, height: height)
//                            let cameraBoundary = MKMapView.CameraBoundary(mapRect: mapRect)
//                            self.setCameraBoundary(cameraBoundary, animated: true)
////                            self.setCamera(<#T##camera: MKMapCamera##MKMapCamera#>, animated: <#T##Bool#>)
//                        }
//
//                    } catch {
//                        print(error)
//                    }
//                }
//
//            }
//        }
//        task.resume()
//    }
    
    
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
                        
                        for point in userRoutes.route.trackPoints {
                            let routePoint = GPXRoutePoint(latitude: point.y, longitude: point.x)
                            self.gpxRoute.points.append(routePoint)
                            self.mapPoints.append(CLLocationCoordinate2D(latitude: routePoint.latitude!, longitude: routePoint.longitude!))

                        }
                        
                        
                        let boundingBox = userRoutes.route.boundingBox

                        DispatchQueue.main.async {
                            
                            
                            let polyline = MKPolyline(coordinates: self.mapPoints, count: self.mapPoints.count)
//                            self.addOverlay(polyline)
                            let render = MKPolylineRenderer(polyline: polyline)
                            self.addOverlay(polyline)
//                            self.addOverlay(polyline)
                            self.addOverlay(polyline)
                            self.partyPaceRoute.RideStartLocation = CLLocation(latitude: userRoutes.route.firstLatitudePoint, longitude: userRoutes.route.firstLongitudePoint)
                            
                            let height = (boundingBox[1].lng + boundingBox[0].lng)/2
                            let width = (boundingBox[1].lat + boundingBox[0].lat)/2
                            
                            let coordinate0 = CLLocation(latitude: boundingBox[1].lat, longitude: boundingBox[1].lng)
                            let coordinate1 = CLLocation(latitude: boundingBox[0].lat, longitude: boundingBox[0].lng)

                            let distanceInMeters = coordinate0.distance(from: coordinate1) // result is in meters
                            
                            let camera = MKMapCamera(lookingAtCenter: CLLocationCoordinate2D(latitude: width, longitude: height), fromEyeCoordinate: CLLocationCoordinate2D(latitude: width, longitude: height), eyeAltitude: CLLocationDistance(distanceInMeters*1.5))
                            self.setCamera(camera, animated: true)
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
    
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
}

extension MiniMap: MKMapViewDelegate {
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
