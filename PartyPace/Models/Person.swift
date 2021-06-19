//
//  Person.swift
//  PartyPace
//
//  Created by Andrew on 6/17/21.
//

import Foundation

struct Person {
    var name: PersonNameComponents?
    
    init(newname: String) {
        name?.familyName = newname
    }
}
