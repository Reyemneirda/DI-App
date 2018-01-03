//
//  Database_Manager.swift
//  DI-App
//
//  Created by Adrien Meyer on 28/12/2017.
//  Copyright © 2017 Developer.Institute. All rights reserved.
//

import Foundation
import Firebase

class DatabaseManager
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
    
}
