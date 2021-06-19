//
//  RideOrganizationViewController.swift
//  PartyPace
//
//  Created by Andrew on 6/18/21.
//

import UIKit

class RideOrganizationViewController: UIViewController {

    @IBOutlet weak var attendanceList: UITableView!
    var attendees: [String] = ["hello", "goodbye"]// [Person(newname: "andrew"), Person(newname: "keryn")]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        attendanceList.delegate = self
        attendanceList.dataSource = self
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


extension RideOrganizationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "attendeeCell", for: indexPath)
        
        cell.textLabel?.text = attendees[indexPath.row] //attendees[indexPath.row].name?.familyName
        return cell
    }
    
    
}
