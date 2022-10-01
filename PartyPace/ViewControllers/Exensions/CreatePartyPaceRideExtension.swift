//
//  CreatePartyPaceRideExtension.swift
//  PartyPace
//
//  Created by Andrew on 7/21/21.
//

import Foundation
import UIKit


extension RideSettingsConfirmationViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        switch pickerView {
        case pacePicker:
            return paceChoices.allCases.count
        case tireSizePicker:
            return tireChoices.allCases.count
        case privacyPicker:
            return privacyChoices.allCases.count
        default: return 0
            
        }
        
        
        
        
        //        if pickerView == pacePicker {
        //            return paceChoices.allCases.count
        //
        //        } else if pickerView == tireSizePicker{
        //            return tireChoices.allCases.count
        //
        //        } else if pickerView == privacyPicker{
        //            return privacyChoices.allCases.count
        //        }
        //        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case pacePicker:
            pace = paceChoices.allCases[row]
            newride.ridePace = pace
            return paceChoices.allCases[row].rawValue
        case tireSizePicker:
            recommendedTireSize = tireChoices.allCases[row]
            newride.minTire = recommendedTireSize
            return tireChoices.allCases[row].rawValue
        case privacyPicker:
            privacySetting = privacyChoices.allCases[row]
            newride.ridePrivacy = privacySetting
            return privacyChoices.allCases[row].rawValue
        default: return ""
            
        }
        
        //        if pickerView == pacePicker {
        //            return paceChoices.allCases[row].rawValue
        //
        //        } else if pickerView == tireSizePicker{
        //            return tireChoices.allCases[row].rawValue
        //
        //        } else if pickerView == privacyPicker{
        //            return privacyChoices.allCases[row].rawValue
        //        }
        //        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case pacePicker:
            pace = paceChoices.allCases[row]
            newride.ridePace = pace
        case tireSizePicker:
            recommendedTireSize = tireChoices.allCases[row]
            newride.minTire = recommendedTireSize
        case privacyPicker:
            privacySetting = privacyChoices.allCases[row]
            newride.ridePrivacy = privacySetting
        default: return
            
        }
        
        
        
        
    }
    
}
