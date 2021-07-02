//
//  ViewController.swift
//  PartyPace
//
//  Created by Andrew Howard on 6/27/21.
//
//struct GroupRide: Decodable {
//
//    let trackPoints: Array<Any>
////    let track_points: String
////    let url: URL
////    let category: Category
////    let views: Int
//    
//}
//    extension GroupRide {
//    enum CodingKeys: CodingKey {
//            case track_points
//
//        }
//        
//        init(from decoder: Decoder) throws {
//            let values = try decoder.container(keyedBy: CodingKeys.self)
//         
//            trackPoints = try values.decode(Route.self, forKey: .track_points)
//         
////                let location = try values.nestedContainer(keyedBy: LocationKeys.self, forKey: .country)
////                country = try location.decode(String.self, forKey: .country)
//         
////                use = try values.decode(String.self, forKey: .use)
////                amount = try values.decode(Int.self, forKey: .amount)
//         
//            }
//
//}
import UIKit

class RideViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://ridewithgps.com/routes/141014.json")
        
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
                        print(route.trackPoints)
                        

                    } catch {
                        print(error)
                    }
                }
            
        }
                }
        task.resume()
    } }

//        let jsonData = JSON.data(using: .utf8)!
//        let blogPost: ride = try! JSONDecoder().decode(ride.self, from: jsonData)
//
//        print(blogPost.url)

        // Do any additional setup after loading the view.
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
//    func getData() {
//        // Create URL
//
//        let url = URL(string: "https://ridewithgps.com/")
//
//        guard let requestUrl = url else { fatalError() }
//
//        // Create URL Request
//        var request = URLRequest(url: requestUrl)
////        let queryItem1 = URLQueryItem(name: "apikey", value: "testkey1")
////        let queryItem2 = URLQueryItem(name: "version", value: "2")
////        let queryItem3 = URLQueryItem(name: "auth_token", value: "942927bd9e0b862a129ce34bb7824b6f")
//
////        let queryItems = [queryItem1, queryItem2, queryItem3]
//        // Specify HTTP Method to use
//        request.httpMethod = "GET"
//        request.addValue("apikey", forHTTPHeaderField: "testkey1")
//        request.addValue("version", forHTTPHeaderField: "2")
//        request.addValue("auth_token", forHTTPHeaderField: "2")
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
//                print("Response data string:\n \(dataString)")
//            }
//
//        }
//        task.resume()    }
//
//}
