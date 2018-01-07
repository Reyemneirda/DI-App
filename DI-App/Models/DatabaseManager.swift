//
//  Database_Manager.swift
//  DI-App
//
//  Created by Adrien Meyer on 28/12/2017.
//  Copyright © 2017 Developer.Institute. All rights reserved.
//

import Foundation
import Firebase

class DatabaseManager: NSObject
{
     static let ref = Database.database().reference(fromURL: "https://di-app-14896.firebaseio.com/")
    
    var name: String
    var phone: String
    var email: String
    var hobbies: String
    var linkedIn: String
    var projects: String
    var session: String
    var courses: [Courses]
    
    
    init(snap: DataSnapshot) {
        
        let userDict = snap.value as! [String: Any]
        
        self.name = userDict["name"] as! String
        self.phone = userDict["phone"] as! String
        self.email = userDict["email"] as! String
        self.hobbies = userDict["hobbies"] as! String
        self.linkedIn = userDict["linkedIn"] as! String
        self.projects = userDict["projects"] as! String
        self.session = userDict["session"] as! String
        self.courses = userDict["session"] as! [Courses]
        
    }
}
