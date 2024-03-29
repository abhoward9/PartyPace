//
//  RideOptions.swift
//  PartyPace
//
//  Created by Andrew Howard on 7/9/21.
//

import Foundation

enum tireChoices: String, CaseIterable, Codable {
    case road
    case over32
    case over40
    case over48
    
}

enum paceChoices: String, CaseIterable, Codable {
    case party, noDrop, cat5, cat4, cat3, cat2, cat1
}

enum privacyChoices: String, CaseIterable, Codable {
    case publicRide
    case privateRide
    case groupRide
    case mutualFriends
    case friendsOfFriends
}
