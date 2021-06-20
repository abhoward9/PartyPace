//
//  Ride.swift
//  PartyPace
//
//  Created by Andrew on 6/18/21.
//

import Foundation


class Ride {
    var name: String?
    var StartTime: Date?
    var ridePrivacy: privacyChoices?
    var ridePace: paceChoices?
    var route: String?
    var minTire: tireChoices?
    
    init(rideName: String?, time: Date, paceSetting: paceChoices, tireRecommendation: tireChoices, privacySetting: privacyChoices) {
        name = rideName
        StartTime = time
        ridePrivacy = privacySetting
        ridePace = paceSetting
        minTire = tireRecommendation
        
    }
    
}
