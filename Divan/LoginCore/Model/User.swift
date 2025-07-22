//
//  User.swift
//  Divan
//
//  Created by Sothesom on 31/04/1404.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    
    // for img profile
    var initials : String {
        let formatter = PersonNameComponentsFormatter()
        if let component  = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: component)
        }
        
        return ""
    }
}


extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Mohammad Karimi", email: "sothesom@gmail.com")
}
