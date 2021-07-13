//
//  URLBuilderManager.swift
//  PartyPace
//
//  Created by Andrew Howard on 7/12/21.
//

import Foundation

func baseURLString() -> String {
//    let email = "abhoward9@icloud.com"
//    let password = "3EWYzfbYmLY8oD"
    return "https://ridewithgps.com"
//    return "http://localhost:8080/"
//    return "https://ridewithgps.com"
}

func userRoutes() -> String {
    //MARK: MY ID
//    let userID = "518136"
    let userID = "1"
    return baseURLString() + "/users/\(userID)/routes.json"
}



func authTokenURL(query: [String: String]) -> URLRequest? {

    let url = URL(string: userRoutes())
//    var components = URLComponents()
//       components.scheme = "http"
//       components.host = "ridewithgps.com"
//       components.path = "users/current.json"

 
    let newURL = url!.withQueries(query)
    
    
    
    guard let requestUrl = newURL else { fatalError() }

    // Create URL Request
    var request = URLRequest(url: requestUrl)

    // Specify HTTP Method to use
    request.httpMethod = "GET"


    
    return request
}

func makeRWGPSRequest() {
    
    let query: [String: String] = [
//        "email": "abhoward9@icloud.com",
//        "apikey": "674d66d1",
////        "email": "abhoward9@icloud.com",
//
//        "password": "3EWYzfbYmLY8oD"
        
          "offset": "0",
          "limit": "1",
          "apikey": "674d66d1",
          "version": "2",
          "auth_token": "b3a08a5799f1810825666a6e84913e18"
        
    ]
    
    guard let requestUrl = authTokenURL(query: query) else { fatalError() }
    
    
    // Create URL Request
    
    
    
    // Send HTTP Request
    print(requestUrl)
    let task = URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
        
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
                    print(dataString)
                    let currentUser = try decoder.decode(UserRoutes.self, from: jsonData)

                    print(currentUser.results[0].id)
                    
                    DispatchQueue.main.async {
                        
                        
                    }
                    
                } catch {
                    print(error)
                }
            }
            
        }
    }
    
    task.resume()
}

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self,
        resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map
{ URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}


