//
//  miniMap.swift
//  PartyPace
//
//  Created by Andrew Howard on 7/5/21.
//

import Foundation
import MapKit
import CoreGPX

class MiniMap: MKMapView {
    var gpxRoute = GPXRoute()
    var mapPoints = [CLLocationCoordinate2D]()
    
 
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
                        DispatchQueue.main.async {
                            
                            
                            let polyline = MKPolyline(coordinates: self.mapPoints, count: self.mapPoints.count)
//                            self.addOverlay(polyline)
                            let render = MKPolylineRenderer(polyline: polyline)
                            self.addOverlay(polyline)
                        }
                        
                    } catch {
                        print(error)
                    }
                }
                
            }
        }
        task.resume()
    }
    
    func loadRoute() {
        let group = DispatchGroup()

//        let urls = [
//            URL(string: userRoutes()),
//        ]
        var identifier: Int?
//        for url in urls {
            group.enter()
            var request = createUserRoutesRequest()
            
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
                        //                                        print(dataString)
                        do {
                            let userRoutes = try decoder.decode(UserRoutes.self, from: jsonData)
                            
                            identifier = userRoutes.results[0].id
                            
                            
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
            self.requestRouteDetailsAndDisplayRoute(identifier: identifier)

                }
        }
        
    
    
    
//    func loadRoute() {
//
//
//        var request = createUserRoutesRequest()
//
//                // Send HTTP Request
//                let task = URLSession.shared.dataTask(with: request!) { (data, response, error) in
//
//                    // Check if Error took place
//                    if let error = error {
//                        print("Error took place \(error)")
//                        return
//                    }
//
//                    // Read HTTP Response Status code
//                    if let response = response as? HTTPURLResponse {
//                        print("Response HTTP Status code: \(response.statusCode)")
//                    }
//
//                    // Convert HTTP Response Data to a simple String
//                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                        let decoder = JSONDecoder()
//
//                        if let jsonData = dataString.data(using: .utf8) {
//                            print(dataString)
//                            do {
//                                let userRoutes = try decoder.decode(UserRoutes.self, from: jsonData)
//
//                                let firstRoute = userRoutes.results[0].id
//
////                                for point in userRoutes.results {
////        //                            print(point)
////                                    let routePoint = GPXRoutePoint(latitude: point.y, longitude: point.x)
////                                    self.gpxRoute.points.append(routePoint)
////        //                            print(routePoint.latitude, routePoint.longitude)
////                                    self.mapPoints.append(CLLocationCoordinate2D(latitude: routePoint.latitude!, longitude: routePoint.longitude!))
////
////
////                                }
//                                DispatchQueue.main.async {
//
//
////                                let polyline = MKPolyline(coordinates: self.mapPoints, count: self.mapPoints.count)
//                        //        mapView.addOverlay(polyline)
//                        //        let render = MKPolylineRenderer(polyline: polyline)
////                                self.addOverlay(polyline)
//                                }
//
//                            } catch {
//                                print(error)
//                            }
//                        }
//
//                    }
//                }
//
//                task.resume()
//    }
    
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
