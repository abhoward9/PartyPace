//
//  Ride.swift
//  PartyPace
//
//  Created by Andrew on 6/18/21.
//

import Foundation
import CoreLocation
import FirebaseDatabase
import FirebaseFirestore


struct RideWithUserPreferences: Codable {
    var coordinate: GeoPoint?
    var name: String?
    var StartTime: Date?
    var ridePrivacy: privacyChoices?
    var ridePace: paceChoices?
    var route: String?
    var minTire: tireChoices?
    var meetupLocation: GeoPoint?

    
//    init(rideName: String?, time: Date, paceSetting: paceChoices, tireRecommendation: tireChoices, privacySetting: privacyChoices) {
//        name = rideName
//        StartTime = time
//        ridePrivacy = privacySetting
//        ridePace = paceSetting
//        minTire = tireRecommendation
//
//    }
    
}
