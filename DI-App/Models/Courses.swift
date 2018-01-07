//
//  Courses.swift
//  DI-App
//
//  Created by Adrien Meyer on 03/01/2018.
//  Copyright © 2018 Developer.Institute. All rights reserved.
//

import Foundation
import Firebase

class Courses: NSObject {
    var name: String
    var date: Date
    var teacher: String
    var content : String
    
    init(snap: DataSnapshot) {
        
        let userDict = snap.value as! [String: Any]
        
        self.name = userDict["name"] as! String
        self.date = userDict["date"] as! Date
        self.teacher = userDict["teacher"] as! String
        self.content = userDict["content"] as! String
        
        
    }
}
