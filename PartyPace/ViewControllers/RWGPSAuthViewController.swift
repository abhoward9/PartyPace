//
//  RWGPSAuthViewController.swift
//  PartyPace
//
//  Created by Andrew Howard on 7/25/21.
//

import UIKit

//struct User: Codable {
//    let user: UserClass
//    let labs: [String: Bool]
//    let additionalDrawerItems: [JSONAny]
//
//    enum CodingKeys: String, CodingKey {
//        case user, labs
//        case additionalDrawerItems = "additional_drawer_items"
//    }
//}

class RWGPSAuthViewController: UIViewController {

    @IBAction func printAuthButtonPressed(_ sender: Any) {
        let defaults = UserDefaults.standard
        print(defaults.string(forKey: "RWGPSAuthKey"))
        
            }
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func getAuthButtonPressed(_ sender: Any) {
        
        let enteredUsername = usernameTextField.text
        let enteredPassword = passwordTextField.text
        
        let AuthTokenQueryItems: query = [
            
              "apikey": "674d66d1",
              "version": "2",
              "email": "\(enteredUsername!)",
            "password": "\(enteredPassword!)"
//            "email": "abhoward9@icloud.com",
//            "password": "3EWYzfbYmLY8oD"
            
            
        ]
        
        guard let requestUrl = getAuthTokenURLRequest(query: AuthTokenQueryItems) else { fatalError() }
        
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
                //                print(dataString)
                if let jsonData = dataString.data(using: .utf8) {
                    //                                        print(dataString)
                    do {
                        let currentUser = try decoder.decode(CurrentUser.self, from: jsonData)
                        let defaults = UserDefaults.standard
                        
                        defaults.set("\(currentUser.user.authToken)", forKey: "RWGPSAuthKey")
                        defaults.set(currentUser.user.id, forKey: "RWGPSCurrentUserID")


                        
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

    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
