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
        
    }

   
}

