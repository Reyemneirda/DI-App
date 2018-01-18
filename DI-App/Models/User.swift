//
//  User.swift
//  DI-App
//
//  Created by Adrien Meyer on 18/01/2018.
//  Copyright © 2018 Developer.Institute. All rights reserved.
//

import Foundation
import Firebase

class User: NSObject
{
    var email: String?
    var hobby: String?
    var linkedIn: String?
    var name: String?
    var phone: String?
    var profilePic: String?
    var projects: String?
    var session: String?
    
    init(dict: [String:AnyObject])
    {
        if let name : String = dict["name"] as? String
        {
            self.name = name
        }
        if let email : String = dict["email"] as? String
        {
            self.email = email
        }
        if let hobby : String = dict["hobby"] as? String
        {
            self.hobby = hobby
        }
        if let linkedIn : String = dict["name"] as? String
        {
            self.linkedIn = linkedIn
        }
        if let phone : String = dict["phone"] as? String
        {
            self.phone = phone
        }
        
        if let profilePic : String = dict["profilePic"] as? String
        {
            self.profilePic = profilePic
        }
        
        if let projects : String = dict["projects"] as? String
        {
            self.projects = projects
        }
        
        if let session : String = dict["session"] as? String
        {
            self.session = session
        }
    }
    
}
