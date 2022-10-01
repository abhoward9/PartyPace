//
//  RideDetailViewController.swift
//  PartyPace
//
//  Created by Andrew Howard on 7/28/21.
//

import UIKit

class RideDetailViewController: UIViewController {
    @IBOutlet weak var RideNameLabel: UILabel!
    
    @IBOutlet weak var PaceLabel: UILabel!
    @IBOutlet weak var AttendingToggle: UISwitch!
    var DisplayedRide: RideWithUserPreferences?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RideNameLabel.text = DisplayedRide?.name
        PaceLabel.text = DisplayedRide?.ridePace?.rawValue
        
    }


}
