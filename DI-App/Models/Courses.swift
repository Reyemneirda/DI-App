//
//  Courses.swift
//  DI-App
//
//  Created by Adrien Meyer on 03/01/2018.
//  Copyright © 2018 Developer.Institute. All rights reserved.
//

import Foundation
import Firebase


class Courses: NSObject
{
    var name: String?
    var teacher: String?
    var descritpion: String?
    var time: String?
  
    init(name: String?, teacher:String?, descritpion: String?, time: String?) {
        self.name = name
        self.teacher = teacher
        self.descritpion = descritpion
        self.time = time
    }
    init(dict:[String:AnyObject])
    {
        if let name : String = dict["name"] as? String
        {
            self.name = name
        }

        if let teacher = dict["teacher"] as? String
        {
            self.teacher = teacher
        }
        
        if let descritpion = dict["description"] as? String
        {
            self.descritpion = descritpion
        }
        
        if let time = dict["time"] as? String
        {
            self.time = time
        }
    }

   
}

