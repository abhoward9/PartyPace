//
//  FindPartyPaceRidesViewController.swift
//  PartyPace
//
//  Created by Andrew Howard on 7/18/21.
//

import UIKit
import FirebaseDatabase
import FirebaseFirestore

class FindPartyPaceRidesViewController: UIViewController {
    
    
    @IBAction func FindRidesButtonPressed(_ sender: Any) {
        findRides()
    }
    
    func findRides() {

        let db = Firestore.firestore()

        let docRef = db.collection("Routes").document("99")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
            
        
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
