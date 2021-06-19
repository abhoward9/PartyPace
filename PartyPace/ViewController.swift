//
//  ViewController.swift
//  PartyPace
//
//  Created by Andrew on 6/17/21.
//

import UIKit
import CoreLocation

enum paceChoices: String, CaseIterable {
    case party, easy, medium, hard, pro
}


class ViewController: UIViewController {
    var rideDate: Date?
    var rideStartLocation, meetupLocation: CLLocation?
    var rideEndLocation: CLLocation?
    

    
    @IBOutlet weak var pacePicker: UIPickerView!
    
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pacePicker.dataSource = self
        pacePicker.delegate = self
        
    }


}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return paceChoices.allCases.count

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        return paceChoices.allCases[row].rawValue
    }
    
}


